class ProjectModel {
  final String id;
  final String name;
  final String description;
  final String status;
  final int progress;
  final DateTime startDate;
  final DateTime endDate;

  ProjectModel({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.progress,
    required this.startDate,
    required this.endDate,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
      progress: int.parse(json['progress'].toString()),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'status': status,
      'progress': progress,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }
}
