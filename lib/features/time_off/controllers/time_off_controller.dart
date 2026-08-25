import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/features/auth/controllers/auth_controller.dart';
import 'package:hrm_app/features/time_off/data/time_off_dummy_data.dart';
import 'package:hrm_app/features/time_off/models/leave_balance_model.dart';
import 'package:hrm_app/features/time_off/models/team_leave_model.dart';
import 'package:hrm_app/features/time_off/models/time_off_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class TimeOffController extends GetxController {
  RxString selectedLeaveType = "".obs;
  final isDaySelected = false.obs;
  Rx<DateTime?> startDate = Rx<DateTime?>(null);
  Rx<DateTime?> endDate = Rx<DateTime?>(null);
  final noteController = TextEditingController();
  Rx<File?> selectedFile = Rx<File?>(null);
  Rx<DateTime?> selectedDay = Rx<DateTime?>(null);
  Rx<DateTime> focusedDay = DateTime.now().obs;
  RxList<TimeOffModel> leaveList = <TimeOffModel>[].obs;
  RxList<LeaveBalanceModel> balanceList = <LeaveBalanceModel>[].obs;
  RxList<TeamLeaveModel> teamLeaveList = <TeamLeaveModel>[].obs;

  @override
  void onInit() {
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
      leaveList.value = TimeOffDummyData.leaves
          .map((e) => TimeOffModel.fromJson(e))
          .toList();
      await saveData();
    } else {
      List data = jsonDecode(leaveData);
      leaveList.value = data.map((e) => TimeOffModel.fromJson(e)).toList();
    }
    teamLeaveList.value = TimeOffDummyData.teamLeave
        .map((e) => TeamLeaveModel.fromJson(e))
        .toList();
  }

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List data = leaveList.map((e) => e.toJson()).toList();
    await prefs.setString("leaveList", jsonEncode(data));
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
    isDaySelected.value = true;
  }

  Future<void> selectDate(bool isStartDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,

      initialDate: DateTime.now(),

      firstDate: DateTime.now(),

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
    if (endDate.value!.isBefore(startDate.value!)) {
      Get.snackbar("Error", "End date cannot be before start date");
      return;
    }
    final auth = Get.find<AuthController>();
    final duration = endDate.value!.difference(startDate.value!).inDays + 1;
    TimeOffModel newLeave = TimeOffModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      employeeId: auth.currentUser.value?.id ?? '',
      employeeName: auth.currentUser.value?.name ?? '',
      allocation: selectedLeaveType.value,
      status: "Pending",
      leaveType: selectedLeaveType.value,
      dateFrom: startDate.value!,
      dateTo: endDate.value!,
      leaveDuration: duration,
      notes: noteController.text,
      attachment: selectedFile.value?.path ?? "",
    );
    leaveList.add(newLeave);
    await saveData();
    clearfilds();
    Get.back();
    Get.snackbar("Success", "Leave Request Submitted");
  }

  Future<void> removeLeave(TimeOffModel leave) async {
    leaveList.removeWhere((e) => e.id == leave.id);
    await saveData();
  }

  void showDeleteDialog(TimeOffModel leave) {
    Get.defaultDialog(
      title: "Delete Leave Request",
      middleText: "Are you sure you want to delete this leave request?",
      textCancel: "Cancel",
      textConfirm: "Delete",

      onCancel: () {
        Get.back();
      },

      onConfirm: () async {
        await removeLeave(leave);
        Get.back(closeOverlays: true);
      },
    );
  }

  void clearfilds() {
    noteController.clear();
    selectedLeaveType.value = "";
    startDate.value = null;
    endDate.value = null;
    selectedFile.value = null;
  }

  List<TeamLeaveModel> get selectedDAyleaves {
    final today = DateTime.now();
    final currentDate = DateTime(today.year, today.month, today.day);
    if (selectedDay.value == null) {
      return teamLeaveList.where((t) {
        final leaveDate = DateTime(
          t.leaveDate.year,
          t.leaveDate.month,
          t.leaveDate.day,
        );
        return !leaveDate.isBefore(currentDate);
      }).toList();
    }
    return teamLeaveList.where((t) {
      final leaveDate = DateTime(
        t.leaveDate.year,
        t.leaveDate.month,
        t.leaveDate.day,
      );
      return !leaveDate.isBefore(currentDate) &&
          isSameDay(t.leaveDate, selectedDay.value);
    }).toList();
  }
}
