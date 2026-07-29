class ProjectModel {
  final String id;
  final String name;
  final String description;
  final String status;
  final double progress;
  final String startDate;
  final String endDate;

  ProjectModel({
    required this.name,
    required this.description,
    required this.status,
    required this.progress,
    required this.startDate,
    required this.endDate,
    required this.id,
  });

  // Map<String, dynamic> toJson() {
  //   return {"name": name, "id": id, "status": status, "Startdate": startDate};
  // }
}
