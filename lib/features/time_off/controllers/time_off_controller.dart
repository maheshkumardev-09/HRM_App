import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/features/time_off/data/time_off_dummy_data.dart';
import 'package:hrm_app/features/time_off/models/leave_balance_model.dart';
import 'package:hrm_app/features/time_off/models/time_off_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeOffController extends GetxController {
  RxString selectedLeaveType = "".obs;
  Rx<DateTime?> startDate = Rx<DateTime?>(null);
  Rx<DateTime?> endDate = Rx<DateTime?>(null);
  final noteController = TextEditingController();
  Rx<File?> selectedFile = Rx<File?>(null);
  Rx<DateTime?> selectedDay = Rx<DateTime?>(null);
  Rx<DateTime> focusedDay = DateTime.now().obs;
  RxList<TimeOffModel> leaveList = <TimeOffModel>[].obs;
  RxList<LeaveBalanceModel> balanceList = <LeaveBalanceModel>[].obs;

  List<String> leaveTypes = [
    "Annual Leave",
    "Sick Leave",
    "Casual Leave",
    "Emergency Leave",
  ];
  @override
  void onInit() {
    // saveData();
    loadData();
    super.onInit();
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    balanceList.value = TimeOffDummyData.leaveBalance
        .map((e) => LeaveBalanceModel.fromJson(e))
        .toList();
    String? leaveData = prefs.getString("leaveList");

    if (leaveData == null) {
      await saveData();
    } else {
      List data = jsonDecode(leaveData);
      leaveList.value = data.map((e) => TimeOffModel.fromJson(e)).toList();
    }
  }

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List leaves = TimeOffDummyData.leaves;
    // List data = leaveList.map((e) => e.toJson()).toList();
    await prefs.setString("leaveList", jsonEncode(leaves));
    leaveList.value = leaves.map((e) => TimeOffModel.fromJson(e)).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return Colors.purple;
      case "In Review":
        return Colors.orange;
      case "Pending":
        return Colors.green;
      case "Rejected":
        return Colors.red;
      default:
        return Colors.black54;
    }
  }

  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay.value = selected;
    focusedDay.value = focused;
  }

  Future<void> selectDate(bool isStartDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,

      initialDate: DateTime.now(),

      firstDate: DateTime(2026),

      lastDate: DateTime(2036),
    );

    if (pickedDate != null) {
      if (isStartDate) {
        startDate.value = pickedDate;
      } else {
        endDate.value = pickedDate;
      }
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf", "png", "jpg", "jpeg"],
    );

    if (result != null) {
      selectedFile.value = File(result.files.single.path!);
    }
  }

  Future<void> addleave() async {
    if (selectedLeaveType.value.isEmpty ||
        startDate.value == null ||
        endDate.value == null) {
      Get.snackbar("Error", "Please fill all fields");

      return;
    }

    final duration = endDate.value!.difference(startDate.value!).inDays + 1;
    TimeOffModel newLeave = TimeOffModel(
      allocation: selectedLeaveType.value,
      status: "Pending",
      leaveType: selectedLeaveType.value,
      dateFrom: startDate.value!,
      dateTo: endDate.value!,
      leaveDuration: duration,
      notes: noteController.text,
    );
    leaveList.add(newLeave);
    await saveData();
    noteController.clear();
    selectedLeaveType.value = "";
    startDate.value = null;
    endDate.value = null;
    Get.back();
    Get.snackbar("Success", "Leave Request Submitted");
  }
}
