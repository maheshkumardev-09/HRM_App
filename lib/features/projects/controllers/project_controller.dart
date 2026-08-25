import 'package:get/get.dart';
import 'package:hrm_app/features/projects/data/projects_dummy_data.dart';
import 'package:hrm_app/features/projects/models/project_model.dart';

class ProjectController extends GetxController {
  final RxString selectedSort = "Name".obs;

  final RxList<ProjectModel> projectList = <ProjectModel>[
    ...ProjectsDummyData.projects.map((e) => ProjectModel.fromJson(e)),
  ].obs;
  ProjectModel? getProjectById(String id) {
    for (var project in projectList) {
      if (project.id == id) return project;
    }
    return null;
  }

  void sortProjects(String value) {
    selectedSort.value = value;
    switch (value) {
      case "Name":
        projectList.sort((a, b) => a.name.compareTo(b.name));
        break;
      case "Status":
        projectList.sort((a, b) => a.status.compareTo(b.status));
        break;
      case "Start Date":
        projectList.sort((a, b) => a.startDate.compareTo(b.startDate));
        break;
    }
  }
}
