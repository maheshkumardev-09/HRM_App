import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/features/time_sheets/data/time_sheet_dummy_data.dart';
import 'package:hrm_app/features/time_sheets/models/time_sheet_model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeSheetController extends GetxController {
  RxList<TimesheetModel> timeSheetList = <TimesheetModel>[].obs;
  TimesheetModel? editingTimesheet;
  int? editingIndex;
  final descriptionController = TextEditingController();
  final hoursController = TextEditingController();
  RxString selectedProject = "".obs;
  RxString selectedTask = "".obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

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

  @override
  void onClose() {
    descriptionController.dispose();

    hoursController.dispose();

    super.onClose();
  }

  void startEdit(TimesheetModel data, int index) {
    editingTimesheet = data;
    editingIndex = index;

    selectedProject.value = data.projectName;

    selectedTask.value = data.taskTitle;

    descriptionController.text = data.description;

    hoursController.text = data.hoursSpent.toString();

    selectedDate.value = DateTime.parse(data.date);
  }

  void clearForm() {
    editingTimesheet = null;
    editingIndex = null;

    selectedProject.value = "";
    selectedTask.value = "";

    selectedDate.value = null;

    descriptionController.clear();

    hoursController.clear();
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

  Future<void> updateTimesheet() async {
    if (editingTimesheet == null) {
      return;
    }
    if (descriptionController.text.isEmpty || hoursController.text.isEmpty) {
      Get.snackbar("Error", "Fill all fields");

      return;
    }
    TimesheetModel updated = TimesheetModel(
      date: selectedDate.value!.toString().substring(0, 10),
      employeeName: editingTimesheet!.employeeName,
      description: descriptionController.text,
      hoursSpent: double.tryParse(hoursController.text) ?? 0,
      taskId: editingTimesheet!.taskId,
      taskTitle: selectedTask.value,
      projectName: selectedProject.value,
    );
    timeSheetList[editingIndex!] = updated;
    await saveData();
    clearForm();
    Get.back();
    Get.snackbar("Success", "Timesheet updated");
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

  List<TimesheetModel> getEntriesByTask(String taskId) {
    return timeSheetList.where((entry) => entry.taskId == taskId).toList();
  }
}
