class TeamLeaveModel {
  final String employeeName;
  final DateTime leaveDate;
  final String startTime;
  final String endTime;
  final String leaveType;

  TeamLeaveModel({
    required this.employeeName,
    required this.leaveDate,
    required this.startTime,
    required this.endTime,
    required this.leaveType,
  });

  factory TeamLeaveModel.fromJson(Map<String, dynamic> json) {
    return TeamLeaveModel(
      employeeName: json["employeeName"] ?? '',
      leaveDate: json["leaveDate"] != null
          ? DateTime.parse(json["leaveDate"])
          : DateTime.now(),
      startTime: json["startTime"] ?? '',
      endTime: json["endTime"] ?? '',
      leaveType: json["leaveType"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "employeeName": employeeName,
      "leaveDate": leaveDate.toIso8601String(),
      "startTime": startTime,
      "endTime": endTime,
      "leaveType": leaveType,
    };
  }
}
