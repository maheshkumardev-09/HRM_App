import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/features/auth/controllers/auth_controller.dart';
import 'package:hrm_app/features/projects/data/projects_dummy_data.dart';
import 'package:hrm_app/features/projects/models/message_mode.dart';
import 'package:hrm_app/features/projects/models/task_model.dart';

class TaskController extends GetxController {
  final messageController = TextEditingController();
  final searchController = TextEditingController();
  final RxString sortBy = 'Newest'.obs;
  final RxString groupBy = 'Stage'.obs;
  final RxString searchQuery = ''.obs;

  final RxList<TaskModel> taskList = <TaskModel>[
    ...ProjectsDummyData.tasks.map((e) => TaskModel.fromJson(e)),
  ].obs;

  List<TaskModel> getTasks({String? projectId}) {
    var list = taskList.toList();
    if (projectId != null) {
      list = list.where((task) => task.projectId == projectId).toList();
    }
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();
      list = list
          .where((task) => task.title.toLowerCase().contains(query))
          .toList();
    }
    sortTasks(list);
    return list;
  }

  List<TaskModel> getTasksByProject(String projectId) {
    return getTasks(projectId: projectId);
  }

  List<TaskModel> get myTasks {
    final auth = Get.find<AuthController>();
    final currentUserName = auth.currentUser.value?.name ?? '';
    final list = taskList
        .where((task) => task.assignee == currentUserName)
        .toList();
    sortTasks(list);
    return list;
  }

  void updateSearch(String value) {
    searchQuery.value = value.trim();
  }

  void clearAllFilter() {
    searchController.clear();
    searchQuery.value = '';
    sortBy.value = 'Newest';
    groupBy.value = 'Stage';
  }

  void setSortBy(String value) {
    sortBy.value = value;
  }

  void sortTasks(List<TaskModel> tasks) {
    switch (sortBy.value) {
      case 'Newest':
        tasks.sort((a, b) => b.deadline.compareTo(a.deadline));
        break;

      case 'Oldest':
        tasks.sort((a, b) => a.deadline.compareTo(b.deadline));
        break;

      case 'Priority':
        tasks.sort((a, b) => b.priority.compareTo(a.priority));
        break;

      case 'Progress':
        tasks.sort((a, b) => b.progress.compareTo(a.progress));
        break;
    }
  }

  void setGroupBy(String value) {
    groupBy.value = value;
  }

  Map<String, List<TaskModel>> groupTasks(List<TaskModel> tasks) {
    final Map<String, List<TaskModel>> grouped = {};
    for (final task in tasks) {
      String key;
      switch (groupBy.value) {
        case 'Stage':
          key = task.taskType;
          break;
        case 'Assignee':
          key = task.assignee;
          break;
        case 'Priority':
          key = 'Priority ${task.priority}';
          break;
        case 'None':
          key = 'All Tasks';
          break;
        default:
          key = 'All Tasks';
      }
      grouped.putIfAbsent(key, () => []);
      grouped[key]!.add(task);
    }
    return grouped;
  }

  TaskModel? getTaskById(String id) {
    return taskList.firstWhereOrNull((task) => task.id == id);
  }

  void sendMessage(String taskId, String messageText) {
    final message = messageText.trim();
    if (message.isEmpty) return;
    final index = taskList.indexWhere((task) => task.id == taskId);
    if (index == -1) return;
    final oldTask = taskList[index];
    final newMessage = MessageModel(
      senderName: 'You',
      message: message,
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
  }
}
