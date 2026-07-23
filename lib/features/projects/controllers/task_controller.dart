import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/features/projects/models/message_mode.dart';
import 'package:hrm_app/features/projects/models/task_model.dart';

class TaskController extends GetxController {
  final messageController = TextEditingController();

  final RxList<TaskModel> taskList = <TaskModel>[
    // Project 1 (Aman Al Bilad) — 3 tasks
    TaskModel(
      id: "1",
      title: "Work of Electrical Wiring",
      taskType: "Material Sourcing",
      assignee: "M. Ahmad",
      totalTime: "12:00:00",
      timeSpent: "07:10:35",
      priority: 3,
      projectId: "1",
      deadline: "04/25/2026 04:00:00 PM",
      progress: 0.6,
      phone: "+966 55 325 1721",
      email: "mahmad812@gmail.com",
      description: [
        "Installed and configured electrical wiring systems as per project requirements",
        "Conducted wiring for lighting, switches, and power outlets",
      ],
      timeRemaining: "04:49:25",
      messages: [
        MessageModel(
          senderName: "M.Ahmad",
          message: "Timesheet updated, thanks",
          sentAt: "Yesterday at 1:35 PM",
        ),
      ],
    ),
    TaskModel(
      id: "2",
      title: "Plumbing Check",
      taskType: "Inspection",
      assignee: "Ali Khan",
      totalTime: "08:00:00",
      timeSpent: "03:00:00",
      priority: 2,
      projectId: "1",
      deadline: "04/18/2026 03:00:00 PM",
      progress: 0.4,
      phone: "+92 311 234 5678",
      email: "alikhan@company.com",
      description: [
        "Check plumbing lines in Building A",
        "Fix any leaks found",
      ],
      timeRemaining: "05:00:00",
      messages: [
        MessageModel(
          senderName: "Ali Khan",
          message: "Inspection done, report attached",
          sentAt: "2 days ago at 11:00 AM",
        ),
      ],
    ),
    TaskModel(
      id: "3",
      title: "Paint Work",
      taskType: "Finishing",
      assignee: "Ahmed Raza",
      totalTime: "10:00:00",
      timeSpent: "02:00:00",
      priority: 1,
      projectId: "1",
      deadline: "04/20/2026 05:00:00 PM",
      progress: 0.2,
      phone: "+92 322 345 6789",
      email: "ahmedraza@company.com",
      description: ["Paint interior walls of Building A"],
      timeRemaining: "08:00:00",
      messages: [],
    ),
    // Project 2 (XYZ Construction) — 2 tasks
    TaskModel(
      id: "4",
      title: "Office Network Setup",
      taskType: "Equipment Installation",
      assignee: "M. Ahmad",
      totalTime: "08:00:00",
      timeSpent: "03:20:15",
      priority: 3,
      projectId: "2",
      deadline: "04/10/2026 02:00:00 PM",
      progress: 0.4,
      phone: "+966 55 325 1721",
      email: "mahmad812@gmail.com",
      description: [
        "Set up new network switches",
        "Configure office Wi-Fi access points",
      ],
      timeRemaining: "04:39:45",
      messages: [
        MessageModel(
          senderName: "M.Ahmad",
          message: "Switches installed, testing Wi-Fi next",
          sentAt: "3 days ago at 4:15 PM",
        ),
      ],
    ),
    TaskModel(
      id: "5",
      title: "Server Maintenance",
      taskType: "System Checking",
      assignee: "Ahmed Raza",
      totalTime: "06:00:00",
      timeSpent: "04:10:00",
      priority: 2,
      projectId: "2",
      deadline: "04/08/2026 01:00:00 PM",
      progress: 0.7,
      phone: "+92 322 345 6789",
      email: "ahmedraza@company.com",
      description: [
        "Run scheduled backup checks",
        "Update server security patches",
      ],
      timeRemaining: "01:50:00",
      messages: [],
    ),
    // Project 3 (Prime Stats) — 1 task
    TaskModel(
      id: "6",
      title: "Data Entry",
      taskType: "Documentation",
      assignee: "Sara Ali",
      totalTime: "05:00:00",
      timeSpent: "02:30:00",
      priority: 1,
      projectId: "3",
      deadline: "04/12/2026 12:00:00 PM",
      progress: 0.5,
      phone: "+92 333 111 2223",
      email: "sara@company.com",
      description: ["Enter monthly financial data into system"],
      timeRemaining: "02:30:00",
      messages: [
        MessageModel(
          senderName: "Sara Ali",
          message: "Half of the data entered so far",
          sentAt: "Today at 9:00 AM",
        ),
      ],
    ),

    TaskModel(
      id: "7",
      title: "Wiring Inspection",
      taskType: "Inspection",
      assignee: "M. Ahmad",
      totalTime: "07:00:00",
      timeSpent: "05:00:00",
      priority: 2,
      projectId: "5",
      deadline: "04/22/2026 03:00:00 PM",
      progress: 0.65,
      phone: "+966 55 325 1721",
      email: "mahmad812@gmail.com",
      description: ["Inspect wiring across all floors"],
      timeRemaining: "02:00:00",
      messages: [],
    ),

    TaskModel(
      id: "8",
      title: "Final Handover",
      taskType: "Documentation",
      assignee: "Ali Khan",
      totalTime: "04:00:00",
      timeSpent: "04:00:00",
      priority: 1,
      projectId: "6",
      deadline: "04/05/2026 10:00:00 AM",
      progress: 1.0,
      phone: "+92 311 234 5678",
      email: "alikhan@company.com",
      description: ["Complete handover documentation for client"],
      timeRemaining: "00:00:00",
      messages: [
        MessageModel(
          senderName: "Ali Khan",
          message: "Handover complete, client signed off",
          sentAt: "Yesterday at 6:00 PM",
        ),
      ],
    ),
  ].obs;

  List<TaskModel> getTasksByProject(String projectId) {
    return taskList.where((task) => task.projectId == projectId).toList();
  }

  TaskModel? getTaskById(String id) {
    return taskList.firstWhereOrNull((task) => task.id == id);
  }

  void sendMessage(String taskId, String messageText) {
    if (messageText.trim().isEmpty) return;

    final index = taskList.indexWhere((task) => task.id == taskId);
    if (index == -1) return;

    final oldTask = taskList[index];

    final newMessage = MessageModel(
      senderName: 'You',
      message: messageText,
      sentAt: 'Just now',
    );

    final updatedTask = TaskModel(
      id: oldTask.id,
      title: oldTask.title,
      taskType: oldTask.taskType,
      assignee: oldTask.assignee,
      totalTime: oldTask.totalTime,
      timeSpent: oldTask.timeSpent,
      priority: oldTask.priority,
      projectId: oldTask.projectId,
      deadline: oldTask.deadline,
      progress: oldTask.progress,
      phone: oldTask.phone,
      email: oldTask.email,
      description: oldTask.description,
      timeRemaining: oldTask.timeRemaining,
      messages: [...oldTask.messages, newMessage],
    );

    taskList[index] = updatedTask;
    taskList.refresh();
  } // ✅ sendMessage yahan khatam hota hai — sahi jagah
}
