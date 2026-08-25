class TimesheetModel {
  final String id;
  final String taskId;
  final String taskName;
  final String projectId;
  final String projectName;
  final String employeeId;
  final String employeeName;

  final DateTime date;
  final String description;
  final double hoursSpent;
  final String status;

  TimesheetModel({
    required this.id,
    required this.taskId,
    required this.taskName,
    required this.projectId,
    required this.projectName,
    required this.employeeId,
    required this.employeeName,
    required this.date,
    required this.description,
    required this.hoursSpent,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "taskId": taskId,
      "taskName": taskName,
      "projectId": projectId,
      "projectName": projectName,
      "employeeId": employeeId,
      "employeeName": employeeName,
      "date": date.toIso8601String(),
      "description": description,
      "hoursSpent": hoursSpent,
      "status": status,
    };
  }

  factory TimesheetModel.fromJson(Map<String, dynamic> json) {
    return TimesheetModel(
      id: json['id'] ?? '',
      taskId: json['taskId'] ?? '',
      taskName: json['taskName'] ?? '',
      projectId: json['projectId'] ?? '',
      projectName: json['projectName'] ?? '',
      employeeId: json['employeeId'] ?? '',
      employeeName: json['employeeName'] ?? '',
      date: DateTime.parse(json['date']),
      description: json['description'] ?? '',
      hoursSpent: (json['hoursSpent'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? 'Pending',
    );
  }
}
