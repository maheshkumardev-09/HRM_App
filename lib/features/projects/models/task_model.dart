class TaskModel {
  final String id;
  final String title;
  final String taskType;
  final String assignee;
  final String totalTime;
  final String timeSpent;
  final int priority;

  TaskModel({
    required this.id,
    required this.title,
    required this.taskType,
    required this.assignee,
    required this.totalTime,
    required this.timeSpent,
    required this.priority,
  });
}
