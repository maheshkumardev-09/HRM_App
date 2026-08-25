import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/features/auth/controllers/auth_controller.dart';
import 'package:hrm_app/features/projects/controllers/project_controller.dart';
import 'package:hrm_app/features/projects/controllers/task_controller.dart';
import 'package:hrm_app/features/projects/models/task_model.dart';
import 'package:hrm_app/features/time_sheets/data/time_sheet_dummy_data.dart';
import 'package:hrm_app/features/time_sheets/models/timesheet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeSheetController extends GetxController {
  RxString filterProject = ''.obs;
  RxString filterTask = ''.obs;
  Rx<DateTime?> filterDateFrom = Rx<DateTime?>(null);
  Rx<DateTime?> filterDateTo = Rx<DateTime?>(null);
  RxList<TimesheetModel> timesheetList = <TimesheetModel>[].obs;
  RxString selectedProject = "".obs;
  RxString selectedTask = "".obs;
  TimesheetModel? editingTimesheet;
  int? editingIndex;
  final descriptionController = TextEditingController();
  final hoursController = TextEditingController();
  final dateController = TextEditingController();
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();
    loadTimesheets();
  }

  void selectProject(String projectName) {
    selectedProject.value = projectName;
    selectedTask.value = '';
  }

  List<TaskModel> get selectedProjectTasks {
    if (selectedProject.value.isEmpty) {
      return [];
    }
    final project = Get.find<ProjectController>().projectList.firstWhereOrNull(
      (project) => project.name == selectedProject.value,
    );
    if (project == null) {
      return [];
    }
    return Get.find<TaskController>().getTasksByProject(project.id);
  }

  void selectTask(String taskName) {
    selectedTask.value = taskName;
  }

  Future<void> loadTimesheets() async {
    final prefs = await SharedPreferences.getInstance();
    String? timesheet = prefs.getString('timesheetlist');
    if (timesheet == null) {
      timesheetList.value = TimesheetDummyData.timesheets
          .map((e) => TimesheetModel.fromJson(e))
          .toList();
      await saveData();
      return;
    } else {
      List data = jsonDecode(timesheet);
      timesheetList.value = data
          .map((e) => TimesheetModel.fromJson(e))
          .toList();
    }
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = timesheetList.map((e) => e.toJson()).toList();
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
    final task = Get.find<TaskController>().taskList.firstWhereOrNull(
      (t) => t.title == selectedTask.value,
    );
    final project = Get.find<ProjectController>().projectList.firstWhereOrNull(
      (p) => p.name == selectedProject.value,
    );
    final auth = Get.find<AuthController>();
    final hours = double.tryParse(hoursController.text.trim());
    if (hours == null || hours <= 0 || hours > 24) {
      Get.snackbar("Error", "Please enter valid hours (1-24)");
      return;
    }
    if (task == null || project == null) {
      Get.snackbar("Error", "Invalid project or task selected");
      return;
    }
    final newTimeSheet = TimesheetModel(
      id: 'TS${timesheetList.length + 1}',
      taskName: selectedTask.value,
      projectName: selectedProject.value,
      employeeId: auth.currentUser.value?.id ?? '',
      employeeName: auth.currentUser.value?.name ?? '',
      date: DateTime.now(),
      description: descriptionController.text,
      hoursSpent: hours,
      status: 'Pending',
      taskId: task.id,
      projectId: project.id,
    );
    timesheetList.add(newTimeSheet);
    await saveData();
    clearForm();
    Get.back();
    Get.snackbar('Successfull', 'New timesheet created');
  }

  Future<void> updateTimesheet() async {
    if (editingTimesheet == null) {
      return;
    }
    final hours = double.tryParse(hoursController.text.trim());
    if (selectedDate.value == null ||
        selectedProject.value.isEmpty ||
        selectedTask.value.isEmpty ||
        descriptionController.text.isEmpty ||
        hours == null ||
        hours <= 0 ||
        hours > 24) {
      Get.snackbar("Error", "Please fill all fields correctly");
      return;
    }
    final task = Get.find<TaskController>().taskList.firstWhereOrNull(
      (t) => t.title == selectedTask.value,
    );
    final project = Get.find<ProjectController>().projectList.firstWhereOrNull(
      (p) => p.name == selectedProject.value,
    );
    if (task == null || project == null) {
      Get.snackbar("Error", "Invalid project or task selected");
      return;
    }
    TimesheetModel updated = TimesheetModel(
      id: editingTimesheet!.id,
      projectId: project.id,
      projectName: selectedProject.value,
      taskId: task.id,
      taskName: selectedTask.value,
      employeeId: editingTimesheet!.employeeId,
      employeeName: editingTimesheet!.employeeName,
      date: selectedDate.value!,
      description: descriptionController.text,
      hoursSpent: hours,
      status: editingTimesheet!.status,
    );
    timesheetList[editingIndex!] = updated;
    await saveData();
    clearForm();
    editingTimesheet = null;
    editingIndex = null;
    Get.back();
    Get.snackbar("Success", "Timesheet updated");
  }

  Future<void> deleteTimesheet(String id) async {
    timesheetList.removeWhere((entry) => entry.id == id);
    await saveData();
  }

  void edit(TimesheetModel data, int index) {
    editingTimesheet = data;
    editingIndex = index;
    selectedProject.value = data.projectName;
    selectedTask.value = data.taskName;
    descriptionController.text = data.description;
    hoursController.text = data.hoursSpent.toString();
    selectedDate.value = data.date;
    dateController.text = data.date.toIso8601String().split('T').first;
  }

  void pickDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );

    if (pickedDate != null) {
      selectedDate.value = pickedDate;
      dateController.text = pickedDate.toIso8601String().split('T').first;
    }
  }

  List<TimesheetModel> getEntriesByTask(String taskId) {
    return timesheetList.where((entry) => entry.taskId == taskId).toList();
  }

  void showDialog(String id) {
    Get.defaultDialog(
      title: 'Are you sure',
      content: Row(
        children: [
          TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
          SizedBox(width: 10),
          TextButton(
            onPressed: () {
              deleteTimesheet(id);
              Get.back();
            },
            child: Text(
              'Delele',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationThickness: 2,
                decorationColor: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<TimesheetModel> get filteredTimesheets {
    var list = timesheetList.toList();
    if (filterProject.value.isNotEmpty) {
      list = list.where((e) => e.projectName == filterProject.value).toList();
    }
    if (filterTask.value.isNotEmpty) {
      list = list.where((e) => e.taskName == filterTask.value).toList();
    }
    if (filterDateFrom.value != null) {
      list = list
          .where((e) => !e.date.isBefore(filterDateFrom.value!))
          .toList();
    }
    if (filterDateTo.value != null) {
      list = list.where((e) => !e.date.isAfter(filterDateTo.value!)).toList();
    }
    return list;
  }

  List<String> get filterTaskOptions {
    if (filterProject.value.isEmpty) {
      return [];
    }
    final project = Get.find<ProjectController>().projectList.firstWhereOrNull(
      (p) => p.name == filterProject.value,
    );
    if (project == null) return [];
    return Get.find<TaskController>()
        .getTasksByProject(project.id)
        .map((t) => t.title)
        .toSet()
        .toList();
  }

  Future<void> pickFilterDateFrom(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (picked != null) filterDateFrom.value = picked;
  }

  Future<void> pickFilterDateTo(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      if (filterDateFrom.value != null &&
          picked.isBefore(filterDateFrom.value!)) {
        Get.snackbar("Error", "To date cannot be before From date");
        return;
      }
      filterDateTo.value = picked;
    }
  }

  void setFilterProject(String value) {
    filterProject.value = (value == 'All Projects') ? '' : value;
    filterTask.value = ''; // <-- ye line important hai
  }

  void setFilterTask(String value) {
    filterTask.value = (value == 'All Tasks') ? '' : value;
  }

  void clearForm() {
    selectedProject.value = '';
    selectedTask.value = '';
    dateController.clear();
    hoursController.clear();
    descriptionController.clear();
  }

  void clearFilter() {
    filterProject.value = '';
    filterTask.value = '';
    filterDateFrom.value = null;
    filterDateTo.value = null;
  }
}
