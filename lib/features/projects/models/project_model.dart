class ProjectModel {
  final String name;
  final String description;
  final int tasks;
  final String status;
  final double progress;
  final String startDate;
  final String endDate;

  ProjectModel({
    required this.name,
    required this.description,
    required this.tasks,
    required this.status,
    required this.progress,
    required this.startDate,
    required this.endDate,
  });
}
