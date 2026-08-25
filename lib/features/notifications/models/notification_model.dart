class NotificationModel {
  final String title;
  final String message;
  final DateTime dateTime;
  final bool isRead;

  NotificationModel({
    required this.title,
    required this.message,
    required this.dateTime,
    this.isRead = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      dateTime:
          DateTime.tryParse(json['dateTime']?.toString() ?? '') ??
          DateTime.now(),
      isRead: json['isRead'] == true || json['isRead'] == 'true',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
      'dateTime': dateTime.toIso8601String(),
      'isRead': isRead,
    };
  }
}
