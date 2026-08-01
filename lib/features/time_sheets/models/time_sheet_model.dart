class TimesheetModel {
  final String taskId;
  final String date;
  final String taskTitle;
  final String projectName;
  final String employeeName;
  final String description;
  final double hoursSpent;

  TimesheetModel({
    required this.date,
    required this.employeeName,
    required this.description,
    required this.hoursSpent,
    required this.taskId,
    required this.taskTitle,
    required this.projectName,
  });

  Map<String, dynamic> toJson() {
    return {
      "taskId": taskId,
      "date": date,
      "taskTitle": taskTitle,
      "projectName": projectName,
      "employeeName": employeeName,
      "description": description,
      "hoursSpent": hoursSpent,
    };
  }

  factory TimesheetModel.FromJson(Map<String, dynamic> json) {
    return TimesheetModel(
      taskId: json['taskId'] ?? '',
      date: json['date'] ?? '',
      taskTitle: json['taskTitle'] ?? '',
      projectName: json['projectName'] ?? '',
      employeeName: json['employeeName'] ?? '',
      description: json['description'] ?? '',
      hoursSpent: (json['hoursSpent'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
