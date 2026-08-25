import 'package:hrm_app/features/projects/models/message_mode.dart';

class TaskModel {
  final String id;
  final String title;
  final String taskType;
  final String assignee;
  final String totalTime;
  final String timeSpent;
  final int priority;
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
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      taskType: json['taskType'] ?? '',
      assignee: json['assignee'] ?? '',
      totalTime: json['totalTime'] ?? '',
      timeSpent: json['timeSpent'] ?? '',
      priority: json['priority'] ?? 0,
      projectId: json['projectId'] ?? '',
      deadline: json['deadline'] ?? '',
      progress: (json['progress'] ?? 0).toDouble(),
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      description: List<String>.from(json['description'] ?? []),
      timeRemaining: json['timeRemaining'] ?? '',
      messages: (json['messages'] as List? ?? [])
          .map((e) => MessageModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'taskType': taskType,
      'assignee': assignee,
      'totalTime': totalTime,
      'timeSpent': timeSpent,
      'priority': priority,
      'projectId': projectId,
      'deadline': deadline,
      'progress': progress,
      'phone': phone,
      'email': email,
      'description': description,
      'timeRemaining': timeRemaining,
      'messages': messages.map((e) => e.toJson()).toList(),
    };
  }
}
