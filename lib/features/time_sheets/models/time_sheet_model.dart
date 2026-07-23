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
}
