class AnnouncementModel {
  final String id;
  final String title;
  final DateTime date;

  AnnouncementModel({
    required this.id,
    required this.title,
    required this.date,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: json['id'],
      title: json['title'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'date': date.toIso8601String()};
  }
}
