class TeamLeaveModel {
  final String employeeName;
  final String employeeImage;
  final DateTime leaveDate;
  final String startTime;
  final String endTime;
  final String leaveType;

  TeamLeaveModel({
    required this.employeeName,
    required this.employeeImage,
    required this.leaveDate,
    required this.startTime,
    required this.endTime,
    required this.leaveType,
  });

  factory TeamLeaveModel.fromJson(Map<String, dynamic> json) {
    return TeamLeaveModel(
      employeeName: json["employeeName"],

      employeeImage: json["employeeImage"],

      leaveDate: DateTime.parse(json["leaveDate"]),

      startTime: json["startTime"],

      endTime: json["endTime"],

      leaveType: json["leaveType"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "employeeName": employeeName,

      "employeeImage": employeeImage,

      "leaveDate": leaveDate.toIso8601String(),

      "startTime": startTime,

      "endTime": endTime,

      "leaveType": leaveType,
    };
  }
}
