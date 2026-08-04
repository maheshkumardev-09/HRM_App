import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/features/time_sheets/data/time_sheet_dummy_data.dart';
import 'package:hrm_app/features/time_sheets/models/time_sheet_model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeSheetController extends GetxController {
  RxList<TimesheetModel> timeSheetList = <TimesheetModel>[].obs;
  RxString selectedProject = "".obs;
  RxString selectedTask = "".obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final descriptionController = TextEditingController();
  final hoursController = TextEditingController();
  List<String> tasks = [
    "Repairing",
    "Work of Electrical Wiring",
    "UI Design",
    "API Integration",
    "Bug Fixing",
    "Testing",
  ];
  List<String> projects = [
    "Aman Al Bilad",
    "Prime Stats",
    "HRM App",
    "E-Commerce App",
  ];

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String? timesheet = prefs.getString('timesheetlist');
    if (timesheet == null) {
      timeSheetList.value = TimeSheetDummyData.timeSheetData
          .map((e) => TimesheetModel.FromJson(e))
          .toList();
      await saveData();
      return;
    } else {
      List data = jsonDecode(timesheet);
      timeSheetList.value = data
          .map((e) => TimesheetModel.FromJson(e))
          .toList();
    }
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = timeSheetList.map((e) => e.toJson()).toList();
    await prefs.setString('timesheetlist', jsonEncode(data));
  }

  Future<void> pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (pickedDate != null) {
      selectedDate.value = pickedDate;
    }
  }

  Future<void> addTimeSheet() async {
    if (selectedDate.value == null ||
        selectedProject.value.isEmpty ||
        selectedTask.value.isEmpty ||
        descriptionController.text.trim().isEmpty ||
        hoursController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }
    final newTimeSheet = TimesheetModel(
      date: DateFormat("yyyy-MM-dd").format(selectedDate.value!),
      employeeName: '',
      description: descriptionController.text,
      hoursSpent: double.parse(hoursController.text),
      taskId: '',
      taskTitle: selectedTask.value,
      projectName: selectedProject.value,
    );
    timeSheetList.add(newTimeSheet);
    await saveData();
    selectedDate.value = null;
    selectedProject.value = '';
    selectedTask.value = '';
    descriptionController.clear();
    hoursController.clear();
    Get.back();
    Get.snackbar('Successfull', 'New timesheet created');
  }

  Future<void> updateTimeSheet(int index, TimesheetModel updatedData) async {
    timeSheetList[index] = updatedData;

    await saveData();

    Get.back();

    Get.snackbar("Success", "Timesheet Updated");
  }

  List<TimesheetModel> getEntriesByTask(String taskId) {
    return timeSheetList.where((entry) => entry.taskId == taskId).toList();
  }
}
