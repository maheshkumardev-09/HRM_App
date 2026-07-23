import 'package:hrm_app/features/projects/models/message_mode.dart';

class TaskModel {
  final String id;
  final String title;
  final String taskType;
  final String assignee;
  final String totalTime;
  final String timeSpent;
  final int priority;
  //new
  final String projectId;
  final String deadline;
  final double progress;
  final String phone;
  final String email;
  final List<String> description;
  final String timeRemaining;
  final List<MessageModel> messages;

  TaskModel({
    required this.id,
    required this.title,
    required this.taskType,
    required this.assignee,
    required this.totalTime,
    required this.timeSpent,
    required this.priority,
    required this.projectId,
    required this.deadline,
    required this.progress,
    required this.phone,
    required this.email,
    required this.description,
    required this.timeRemaining,
    required this.messages,
  });
}
