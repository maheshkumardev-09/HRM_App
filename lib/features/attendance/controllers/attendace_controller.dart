import 'package:get/get.dart';
import 'package:hrm_app/features/attendance/models/attendace_model.dart';
import 'package:hrm_app/features/attendance/models/attendece_history_model.dart';
import 'package:hrm_app/features/attendance/models/region_model.dart';

class AttendanceController extends GetxController {
  void checkIn() {
    currentAttendance.value = AttendanceModel(
      status: 'In Progress',
      checkInTime: DateTime.now(),
    );
  }

  void checkOut() {
    final current = currentAttendance.value;
    currentAttendance.value = AttendanceModel(
      status: 'Checked Out',
      checkInTime: current.checkInTime,
      checkOutTime: DateTime.now(),
    );
  }

  var currentAttendance = AttendanceModel(
    status: 'In Progress',
    checkInTime: DateTime(2025, 3, 6, 16, 27),
    breakInTime: DateTime(2025, 3, 6, 16, 27),
  ).obs;

  var attendanceHistory = <AttendanceHistoryModel>[
    AttendanceHistoryModel(
      date: DateTime(2025, 3, 6),
      checkInTime: DateTime(2025, 3, 6, 16, 0),
      checkOutTime: DateTime(2025, 3, 6, 14, 30),
      totalHours: '14:30',
    ),
    AttendanceHistoryModel(
      date: DateTime(2025, 3, 7),
      checkInTime: DateTime(2025, 3, 7, 16, 0),
      checkOutTime: DateTime(2025, 3, 7, 14, 30),
      totalHours: '14:30',
    ),
    AttendanceHistoryModel(
      date: DateTime(2025, 3, 7),
      checkInTime: DateTime(2025, 3, 7, 16, 0),
      checkOutTime: DateTime(2025, 3, 7, 14, 30),
      totalHours: '14:30',
    ),
  ].obs;

  var regions = <RegionModel>[
    RegionModel(id: '1', name: 'Karachi'),
    RegionModel(id: '2', name: 'Lahore'),
  ].obs;
  // 🔹 Break In function
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

  // 🔹 Break Out function
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
