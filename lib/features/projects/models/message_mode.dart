class MessageModel {
  final String senderName;
  final String message;
  final String sentAt; // "Yesterday at 1:35 PM"

  MessageModel({
    required this.senderName,
    required this.message,
    required this.sentAt,
  });
}
