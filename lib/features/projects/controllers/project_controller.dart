import 'package:get/get.dart';
import 'package:hrm_app/features/projects/models/project_model.dart';

class ProjectController extends GetxController {
  final RxList<ProjectModel> projectList = [
    ProjectModel(
      name: "Aman Al Bilad",
      description: "This is description of Project 1",
      status: "Active",
      progress: 0.5,
      startDate: "01 July 2026",
      endDate: "30 July 2026",
      id: '1',
    ),

    ProjectModel(
      id: '2',
      name: "XYZ Construction",
      description: "This is description of Project 2",
      status: "Completed",
      progress: 1.0,
      startDate: "05 June 2026",
      endDate: "25 June 2026",
    ),

    ProjectModel(
      id: '3',
      name: "Prime Stats",
      description: "This is description of Project 3",
      status: "Pending",
      progress: 0.3,
      startDate: "10 July 2026",
      endDate: "10 August 2026",
    ),

    ProjectModel(
      id: '4',
      name: "Aman Al Bilad",
      description: "This is description of Project 4",
      status: "Draft",
      progress: 0.0,
      startDate: "15 July 2026",
      endDate: "15 August 2026",
    ),

    ProjectModel(
      id: '5',
      name: "XYZ Construction",
      description: "This is description of Project 5",

      status: "Active",
      progress: 0.7,
      startDate: "01 May 2026",
      endDate: "30 June 2026",
    ),

    ProjectModel(
      id: '6',
      name: "XYZ Construction",
      description: "This is description of Project 6",
      status: "Completed",
      progress: 1.0,
      startDate: "01 April 2026",
      endDate: "20 May 2026",
    ),
  ].obs;
  ProjectModel? getProjectById(String id) {
    for (var project in projectList) {
      if (project.id == id) return project;
    }
    return null;
  }
}
