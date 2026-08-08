import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:hrm_app/features/attendance/data/attenddance_dummy_data.dart';
import 'package:hrm_app/features/attendance/models/attendace_model.dart';
import 'package:hrm_app/features/attendance/models/attendece_history_model.dart';
import 'package:hrm_app/features/attendance/models/region_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceController extends GetxController {
  Timer? timer;
  RxString workingTime = "00:00:00".obs;
  RxList<AttendanceHistoryModel> attendancelist =
      <AttendanceHistoryModel>[].obs;
  var regions = <RegionModel>[
    RegionModel(id: '1', name: 'Karachi'),
    RegionModel(id: '2', name: 'Lahore'),
  ].obs;
  String calculateTotalHours(
    DateTime checkIn,
    DateTime checkOut,
    DateTime? breakIn,
    DateTime? breakOut,
  ) {
    Duration totalDuration = checkOut.difference(checkIn);
    if (breakIn != null && breakOut != null) {
      final breakDuration = breakOut.difference(breakIn);
      totalDuration = totalDuration - breakDuration;
    }
    final hours = totalDuration.inHours;
    final minutes = totalDuration.inMinutes % 60;
    return '$hours:${minutes.toString().padLeft(2, '0')}';
  }

  final Rx<AttendanceModel> currentAttendance = AttendanceModel(
    status: 'Not Started',
  ).obs;
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('attendanceHistorys');
    if (data == null) {
      attendancelist.value = AttenddanceDummyData.attendanceHistory
          .map((e) => AttendanceHistoryModel.fromJson(e))
          .toList();
    } else {
      List list = jsonDecode(data);
      attendancelist.value = list
          .map((e) => AttendanceHistoryModel.fromJson(e))
          .toList();
    }
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = attendancelist.map((e) => e.toJson()).toList();
    await prefs.setString('attendanceHistorys', jsonEncode(data));
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final checkIn = currentAttendance.value.checkInTime;

      if (checkIn != null) {
        final duration = DateTime.now().difference(checkIn);

        final hours = duration.inHours;
        final minutes = duration.inMinutes % 60;

        workingTime.value = '$hours Hours $minutes minutes since check-in';
      }
    });
  }

  void checkIn() {
    currentAttendance.value = AttendanceModel(
      status: 'In Progress',
      checkInTime: DateTime.now(),
    );
    startTimer();
  }

  void checkOut() {
    timer?.cancel();
    final current = currentAttendance.value;
    final checkoutTime = DateTime.now();
    final total = calculateTotalHours(
      current.checkInTime!,
      checkoutTime,
      current.breakInTime,
      current.breakOutTime,
    );
    currentAttendance.value = AttendanceModel(
      status: 'Checked Out',
      checkInTime: current.checkInTime,
      checkOutTime: checkoutTime,
    );
    final attendance = AttendanceHistoryModel(
      date: DateTime.now(),
      checkInTime: current.checkInTime!,
      checkOutTime: checkoutTime,
      totalHours: total,
    );
    attendancelist.add(attendance);
    saveData();
  }

  void breakIn() {
    final current = currentAttendance.value;
    currentAttendance.value = AttendanceModel(
      status: current.status,
      checkInTime: current.checkInTime,
      checkOutTime: current.checkOutTime,
      breakInTime: DateTime.now(),
      breakOutTime: current.breakOutTime,
    );
  }

  void breakOut() {
    final current = currentAttendance.value;
    currentAttendance.value = AttendanceModel(
      status: current.status,
      checkInTime: current.checkInTime,
      checkOutTime: current.checkOutTime,
      breakInTime: current.breakInTime,
      breakOutTime: DateTime.now(),
    );
  }
}
