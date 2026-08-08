class AttendanceHistoryModel {
  final DateTime date;
  final DateTime checkInTime;
  final DateTime checkOutTime;
  final String totalHours;

  AttendanceHistoryModel({
    required this.date,
    required this.checkInTime,
    required this.checkOutTime,
    required this.totalHours,
  });

  factory AttendanceHistoryModel.fromJson(Map<String, dynamic> json) {
    return AttendanceHistoryModel(
      date: DateTime.parse(json['date']),
      checkInTime: DateTime.parse(json['checkInTime']),
      checkOutTime: DateTime.parse(json['checkOutTime']),
      totalHours: json['totalHours'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "date": date.toIso8601String(),
      "checkInTime": checkInTime.toIso8601String(),
      "checkOutTime": checkOutTime.toIso8601String(),
      "totalHours": totalHours,
    };
  }
}
