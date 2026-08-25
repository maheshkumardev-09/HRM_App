class AnnouncementModel {
  final String sentBy;
  final String title;
  final String message;
  final DateTime dateTime;

  AnnouncementModel({
    required this.title,
    required this.message,
    required this.dateTime,
    required this.sentBy,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      title: json['title']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      dateTime:
          DateTime.tryParse(json['dateTime']?.toString() ?? '') ??
          DateTime.now(),
      sentBy: json['sentby'] ?? 'Admain',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sentby': sentBy,
      'title': title,
      'message': message,
      'dateTime': dateTime.toIso8601String(),
    };
  }
}
