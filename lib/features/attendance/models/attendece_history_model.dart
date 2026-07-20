class AttendanceHistoryModel {
  final DateTime date;
  final DateTime checkInTime;
  final DateTime checkOutTime;
  final String
  totalHours; // ya double bhi rakh sakte hain, jaise "14:30 PM" text hai screenshot mein (thoda unusual format hai)

  AttendanceHistoryModel({
    required this.date,
    required this.checkInTime,
    required this.checkOutTime,
    required this.totalHours,
  });
}
