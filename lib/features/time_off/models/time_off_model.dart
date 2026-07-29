class TimeOffModel {
  final String allocation;
  final String status;
  final String leaveType;
  final DateTime dateFrom;
  final DateTime dateTo;
  final int leaveDuration;
  final String notes;

  TimeOffModel({
    required this.allocation,
    required this.status,
    required this.leaveType,
    required this.dateFrom,
    required this.dateTo,
    required this.leaveDuration,
    required this.notes,
  });

  factory TimeOffModel.fromJson(Map<String, dynamic> json) {
    return TimeOffModel(
      allocation: json['allocation'],
      status: json['status'],
      leaveType: json['leaveType'],
      dateFrom: DateTime.parse(json['dateFrom']),
      dateTo: DateTime.parse(json['dateTo']),
      leaveDuration: json['duration'],
      notes: json["note"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "allocation": allocation,
      "status": status,
      "leaveType": leaveType,
      "dateFrom": dateFrom.toString(),
      "dateTo": dateTo.toString(),
      "duration": leaveDuration,
      "note": notes,
    };
  }
}
