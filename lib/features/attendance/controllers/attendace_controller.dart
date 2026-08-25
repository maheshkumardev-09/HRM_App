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
import 'package:hrm_app/features/auth/controllers/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceController extends GetxController {
  RxList<Country> regions = <Country>[].obs;
  RxList<City> subRegions = <City>[].obs;
  Rx<Country?> selectedRegion = Rx<Country?>(null);
  Rx<City?> selectedSubRegion = Rx<City?>(null);
  RxBool isProcessing = false.obs;
  Timer? timer;
  Timer? _clockTimer;
  Rx<DateTime> currentTime = DateTime.now().obs;
  RxInt seconds = 0.obs;
  RxList<AttendanceHistoryModel> attendancelist =
      <AttendanceHistoryModel>[].obs;
  String get _employeeId {
    final auth = Get.find<AuthController>();
    return auth.currentUser.value?.id ?? 'guest';
  }

  String get _historyKey => 'attendanceHistorys_$_employeeId';
  String get _currentAttendanceKey => 'current_attendance_$_employeeId';

  String calculateTotalHours(
    DateTime checkIn,
    DateTime checkOut,
    DateTime? breakIn,
    DateTime? breakOut,
  ) {
    final totalDuration = checkOut.difference(checkIn);
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
    _init();
  }

  Future<void> _init() async {
    final auth = Get.find<AuthController>();
    if (auth.currentUser.value == null) {
      await auth.ensureUserLoaded();
    }
    await loadData();
    await _restoreCurrentAttendance();
    _startClockTicker();
  }

  @override
  void onReady() {
    super.onReady();
    loadRegions();
  }

  @override
  void onClose() {
    timer?.cancel();
    _clockTimer?.cancel();
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
    final data = prefs.getString(_historyKey);
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
    await prefs.setString(_historyKey, jsonEncode(data));
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
    final now = DateTime.now();
    final alreadyCheckedInToday = attendancelist.any(
      (attendance) =>
          attendance.date.year == now.year &&
          attendance.date.month == now.month &&
          attendance.date.day == now.day,
    );
    if (alreadyCheckedInToday) {
      return;
    }
    currentAttendance.value = AttendanceModel(
      status: 'In Progress',
      checkInTime: DateTime.now(),
    );
    startTimer();
    _saveCurrentAttendance();
  }

  void checkOut() {
    final current = currentAttendance.value;
    if (current.checkInTime == null) {
      return;
    }
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
        country: selectedRegion.value?.name ?? '',
        city: selectedSubRegion.value?.name ?? '',
      ),
    );
    attendancelist.add(attendance);
    stopTimer();
    saveData();
    _saveCurrentAttendance();
  }

  Future<void> _saveCurrentAttendance() async {
    final prefs = await SharedPreferences.getInstance();
    final model = currentAttendance.value;
    await prefs.setString(
      _currentAttendanceKey,
      jsonEncode({
        'status': model.status,
        'checkInTime': model.checkInTime?.toIso8601String(),
        'checkOutTime': model.checkOutTime?.toIso8601String(),
        'breakInTime': model.breakInTime?.toIso8601String(),
        'breakOutTime': model.breakOutTime?.toIso8601String(),
      }),
    );
  }

  Future<void> _restoreCurrentAttendance() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_currentAttendanceKey);
    if (data == null) return;
    final map = jsonDecode(data);
    final status = map['status'] as String;
    final checkInTime = map['checkInTime'] != null
        ? DateTime.parse(map['checkInTime'])
        : null;
    final checkOutTime = map['checkOutTime'] != null
        ? DateTime.parse(map['checkOutTime'])
        : null;
    final breakInTime = map['breakInTime'] != null
        ? DateTime.parse(map['breakInTime'])
        : null;
    final breakOutTime = map['breakOutTime'] != null
        ? DateTime.parse(map['breakOutTime'])
        : null;
    if (status == 'In Progress' && checkInTime != null) {
      final now = DateTime.now();
      final isSameDay =
          checkInTime.year == now.year &&
          checkInTime.month == now.month &&
          checkInTime.day == now.day;
      if (!isSameDay) {
        currentAttendance.value = AttendanceModel(status: 'Not Started');
        await _saveCurrentAttendance();
        return;
      }
    }
    currentAttendance.value = AttendanceModel(
      status: status,
      checkInTime: checkInTime,
      checkOutTime: checkOutTime,
      breakInTime: breakInTime,
      breakOutTime: breakOutTime,
    );

    if (status == 'In Progress' && checkInTime != null) {
      final elapsed = DateTime.now().difference(checkInTime).inSeconds;
      _startTimerFrom(elapsed);
    }
  }

  void _startTimerFrom(int startSeconds) {
    timer?.cancel();
    seconds.value = startSeconds;
    timer = Timer.periodic(const Duration(seconds: 1), (_) => seconds.value++);
  }

  void _startClockTicker() {
    _clockTimer?.cancel();
    Timer.periodic(const Duration(seconds: 1), (_) {
      currentTime.value = DateTime.now();
    });
  }

  void startTimer() {
    _startTimerFrom(0);
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
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
    _saveCurrentAttendance();
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
    _saveCurrentAttendance();
  }

  String get buttonLabel {
    final data = currentAttendance.value;
    if (data.status != 'In Progress') {
      return 'Check In';
    }
    if (data.breakInTime == null) {
      return 'Break In';
    }
    if (data.breakOutTime == null) {
      return 'Break Out';
    }
    return 'Check Out';
  }

  void handleButtonTap() async {
    if (isProcessing.value) return;
    isProcessing.value = true;
    switch (buttonLabel) {
      case 'Check In':
        checkIn();
        break;
      case 'Break In':
        breakIn();
        break;
      case 'Break Out':
        breakOut();
        break;
      case 'Check Out':
        checkOut();
        break;
    }
    await Future.delayed(Duration(milliseconds: 500));
    isProcessing.value = false;
  }
}
