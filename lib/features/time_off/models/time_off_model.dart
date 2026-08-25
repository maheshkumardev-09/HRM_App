class TimeOffModel {
  final String id;
  final String allocation;
  final String status;
  final String leaveType;
  final DateTime dateFrom;
  final DateTime dateTo;
  final int leaveDuration;
  final String notes;
  final String attachment;
  final String employeeId;
  final String employeeName;

  TimeOffModel({
    required this.id,
    required this.allocation,
    required this.status,
    required this.leaveType,
    required this.dateFrom,
    required this.dateTo,
    required this.leaveDuration,
    required this.notes,
    required this.attachment,
    required this.employeeId,
    required this.employeeName,
  });

  factory TimeOffModel.fromJson(Map<String, dynamic> json) {
    return TimeOffModel(
      id: json['id'] ?? '',
      allocation: json['allocation'] ?? '',
      status: json['status'] ?? 'Pending',
      leaveType: json['leaveType'] ?? '',
      dateFrom: json['dateFrom'] != null
          ? DateTime.parse(json['dateFrom'])
          : DateTime.now(),
      dateTo: json['dateTo'] != null
          ? DateTime.parse(json['dateTo'])
          : DateTime.now(),
      leaveDuration: json['duration'] ?? 0,
      notes: json["note"] ?? "",
      attachment: json["attachment"] ?? "",
      employeeId: json["employeeId"] ?? '',
      employeeName: json["employeeName"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "allocation": allocation,
      "status": status,
      "leaveType": leaveType,
      "dateFrom": dateFrom.toIso8601String(),
      "dateTo": dateTo.toIso8601String(),
      "duration": leaveDuration,
      "note": notes,
      "attachment": attachment,
      "employeeId": employeeId,
      "employeeName": employeeName,
    };
  }
}
