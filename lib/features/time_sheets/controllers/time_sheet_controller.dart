import 'dart:convert';

import 'package:get/get.dart';
import 'package:hrm_app/features/time_sheets/data/time_sheet_dummy_data.dart';
import 'package:hrm_app/features/time_sheets/models/time_sheet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeSheetController extends GetxController {
  RxList<TimesheetModel> timeSheetList = <TimesheetModel>[].obs;

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

  Future<void> addTimeSheet() async {
    final newTimeSheet = TimesheetModel(
      date: '',
      employeeName: '',
      description: '',
      hoursSpent: 0.0,
      taskId: '',
      taskTitle: '',
      projectName: '',
    );
    timeSheetList.add(newTimeSheet);
    await saveData();

    Get.back();
    Get.snackbar('Seccussfull', 'New timesheet created');
  }

  List<TimesheetModel> getEntriesByTask(String taskId) {
    return timeSheetList.where((entry) => entry.taskId == taskId).toList();
  }
}
