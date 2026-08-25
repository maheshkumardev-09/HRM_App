class MessageModel {
  final String senderName;
  final String message;
  final String sentAt; // "Yesterday at 1:35 PM"

  MessageModel({
    required this.senderName,
    required this.message,
    required this.sentAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderName: json['sendername'],
      message: json['message'],
      sentAt: json['sentat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'sendername': senderName, 'message': message, 'sentat': sentAt};
  }
}
