class AttendanceModel {
  final String status;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;
  final DateTime? breakInTime;
  final DateTime? breakOutTime;

  AttendanceModel({
    required this.status,
    this.checkInTime,
    this.checkOutTime,
    this.breakInTime,
    this.breakOutTime,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      status: json['status'],
      checkInTime: DateTime.parse(json['checkInTime']),
      checkOutTime: DateTime.parse(json['checkOutTime']),
      breakInTime: DateTime.parse(json['breakInTime']),
      breakOutTime: DateTime.parse(json['breakOutTime']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'checkInTime': checkInTime?.toIso8601String(),
      'checkOutTime': checkOutTime?.toIso8601String(),
      'breakInTime': breakInTime?.toIso8601String(),
      'breakOutTime': breakOutTime?.toIso8601String(),
    };
  }
}
