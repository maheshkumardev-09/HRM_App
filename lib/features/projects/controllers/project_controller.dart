import 'package:get/get.dart';
import 'package:hrm_app/features/projects/models/project_model.dart';
import 'package:hrm_app/features/projects/models/task_model.dart';

class ProjectController extends GetxController {
  final RxList<ProjectModel> projectList = [
    ProjectModel(
      name: "Aman Al Bilad",
      description: "This is description of Project 1",
      tasks: 3,
      status: "Active",
      progress: 0.5,
      startDate: "01 July 2026",
      endDate: "30 July 2026",
    ),

    ProjectModel(
      name: "XYZ Construction",
      description: "This is description of Project 2",
      tasks: 12,
      status: "Completed",
      progress: 1.0,
      startDate: "05 June 2026",
      endDate: "25 June 2026",
    ),

    ProjectModel(
      name: "Prime Stats",
      description: "This is description of Project 3",
      tasks: 12,
      status: "Pending",
      progress: 0.3,
      startDate: "10 July 2026",
      endDate: "10 August 2026",
    ),

    ProjectModel(
      name: "Aman Al Bilad",
      description: "This is description of Project 4",
      tasks: 0,
      status: "Draft",
      progress: 0.0,
      startDate: "15 July 2026",
      endDate: "15 August 2026",
    ),

    ProjectModel(
      name: "XYZ Construction",
      description: "This is description of Project 5",
      tasks: 9,
      status: "Active",
      progress: 0.7,
      startDate: "01 May 2026",
      endDate: "30 June 2026",
    ),

    ProjectModel(
      name: "XYZ Construction",
      description: "This is description of Project 6",
      tasks: 9,
      status: "Completed",
      progress: 1.0,
      startDate: "01 April 2026",
      endDate: "20 May 2026",
    ),
  ].obs;
  final RxList<TaskModel> taskList = [
    TaskModel(
      id: "1",
      title: "Work of Electrical Wiring",
      taskType: "Material Sourcing",
      assignee: "M. Ahmad",
      totalTime: "12:00:00",
      timeSpent: "07:10:35",
      priority: 3,
    ),

    TaskModel(
      id: "2",
      title: "Work of Electrical Wiring",
      taskType: "Material Sourcing",
      assignee: "M. Ahmad",
      totalTime: "12:00:00",
      timeSpent: "07:10:35",
      priority: 2,
    ),

    TaskModel(
      id: "3",
      title: "Work of Electrical Wiring",
      taskType: "Material Sourcing",
      assignee: "Ali Khan",
      totalTime: "10:00:00",
      timeSpent: "05:45:20",
      priority: 1,
    ),

    TaskModel(
      id: "4",
      title: "Office Network Setup",
      taskType: "Equipment Installation",
      assignee: "M. Ahmad",
      totalTime: "08:00:00",
      timeSpent: "03:20:15",
      priority: 3,
    ),

    TaskModel(
      id: "5",
      title: "Server Maintenance",
      taskType: "System Checking",
      assignee: "Ahmed Raza",
      totalTime: "06:00:00",
      timeSpent: "04:10:00",
      priority: 2,
    ),
  ].obs;
}
