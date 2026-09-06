class RequestModel {
  final String id;
  final String requestType;
  final String subject;
  final String description;
  final String status;
  final DateTime startDate;
  final DateTime endDate;
  final String? attachmentPath;
  final String employeeId;
  final String employeeName;
  final Map<String, String> extraFields;

  RequestModel({
    required this.id,
    required this.requestType,
    required this.subject,
    required this.description,
    required this.status,
    required this.startDate,
    required this.endDate,
    this.attachmentPath,
    required this.employeeId,
    required this.employeeName,
    this.extraFields = const {},
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['id'] ?? '',
      requestType: json['requestType'] ?? '',
      subject: json['subject'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? 'Pending',
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'])
          : DateTime.now(),
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'])
          : DateTime.now(),
      attachmentPath: json['attachmentPath'],
      employeeId: json['employeeId'] ?? '',
      employeeName: json['employeeName'] ?? '',
      extraFields: json['extraFields'] != null
          ? Map<String, String>.from(json['extraFields'])
          : {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "requestType": requestType,
      "subject": subject,
      "description": description,
      "status": status,
      "startDate": startDate.toIso8601String(),
      "endDate": endDate.toIso8601String(),
      "attachmentPath": attachmentPath,
      "employeeId": employeeId,
      "employeeName": employeeName,
      "extraFields": extraFields,
    };
  }
}
