import 'dart:async';
import 'dart:convert';

import 'package:country_state_city/models/city.dart';
import 'package:country_state_city/models/country.dart';
import 'package:country_state_city/utils/city_utils.dart';
import 'package:country_state_city/utils/country_utils.dart';
import 'package:get/get.dart';
import 'package:hrm_app/features/attendance/data/attenddance_dummy_data.dart';
import 'package:hrm_app/features/attendance/models/attendace_model.dart';
import 'package:hrm_app/features/attendance/models/attendece_history_model.dart';
import 'package:hrm_app/features/attendance/models/region_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceController extends GetxController {
  RxList<Country> regions = <Country>[].obs;
  RxList<City> subRegions = <City>[].obs;
  Rx<Country?> selectedRegion = Rx<Country?>(null);
  Rx<City?> selectedSubRegion = Rx<City?>(null);
  Timer? timer;
  Rx<DateTime> currentTime = DateTime.now().obs;
  RxInt seconds = 0.obs;
  RxList<AttendanceHistoryModel> attendancelist =
      <AttendanceHistoryModel>[].obs;
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

  @override
  void onReady() {
    super.onReady();
    loadRegions();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  Future<void> loadRegions() async {
    regions.value = await getAllCountries();
  }

  Future<void> setRegion(Country country) async {
    selectedRegion.value = country;
    selectedSubRegion.value = null;
    final cities = await getCountryCities(country.isoCode);
    subRegions.value = cities;
  }

  void setSubRegion(City city) {
    selectedSubRegion.value = city;
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
    timer?.cancel();
    seconds.value = 0;

    timer = Timer.periodic(const Duration(seconds: 1), (_) => seconds.value++);
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
  }

  String get workingTime {
    final hours = seconds.value ~/ 3600;
    final minutes = (seconds.value % 3600) ~/ 60;
    final secondsValue = seconds.value % 60;

    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${secondsValue.toString().padLeft(2, '0')}';
  }

  void checkIn() {
    currentAttendance.value = AttendanceModel(
      status: 'In Progress',
      checkInTime: DateTime.now(),
    );
    startTimer();
  }

  void checkOut() {
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
      region: RegionModel(
        country: selectedRegion.value!.name,
        city: selectedSubRegion.value!.name,
      ),
    );
    attendancelist.add(attendance);
    stopTimer();

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
