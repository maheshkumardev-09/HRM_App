import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/features/time_off/models/time_off_model.dart';

class TimeOffController extends GetxController {
  Rx<DateTime> focusedDay = DateTime.now().obs;

  Rx<DateTime?> selectedDay = Rx<DateTime?>(null);

  final RxList<TimeOffModel> timeOffList = [
    TimeOffModel(
      allocation: "Annual Leave",
      status: "Approved",
      leaveType: "Casual Leave",
      dateFrom: DateTime(2026, 07, 10),
      dateTo: DateTime(2026, 07, 12),
      leaveDuration: 3,
    ),

    TimeOffModel(
      allocation: "Sick Leave",
      status: "Pending",
      leaveType: "Medical Leave",
      dateFrom: DateTime(2026, 07, 15),
      dateTo: DateTime(2026, 07, 16),
      leaveDuration: 2,
    ),

    TimeOffModel(
      allocation: "Annual Leave",
      status: "Rejected",
      leaveType: "Personal Leave",
      dateFrom: DateTime(2026, 08, 1),
      dateTo: DateTime(2026, 08, 3),
      leaveDuration: 3,
    ),

    TimeOffModel(
      allocation: "Emergency Leave",
      status: "Approved",
      leaveType: "Emergency",
      dateFrom: DateTime(2026, 08, 20),
      dateTo: DateTime(2026, 08, 20),
      leaveDuration: 1,
    ),
  ].obs;

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
}
