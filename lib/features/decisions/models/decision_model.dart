class DecisionModel {
  final String id;
  final String title; // e.g. "Terminate", "Promotion", "Change Salary"
  final String employeeName;
  final DateTime date;
  final String status;

  // Quick Info section — approval/rejection metadata
  final String? approvedBy;
  final DateTime? approvedDate;
  final String? rejectedBy;
  final DateTime? rejectedDate;

  DecisionModel({
    required this.id,
    required this.title,
    required this.employeeName,
    required this.date,
    required this.status,
    this.approvedBy,
    this.approvedDate,
    this.rejectedBy,
    this.rejectedDate,
  });

  factory DecisionModel.fromJson(Map<String, dynamic> json) {
    return DecisionModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      employeeName: json['employeeName'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      status: json['status'] ?? 'Pending',
      approvedBy: json['approvedBy'],
      approvedDate: json['approvedDate'] != null
          ? DateTime.tryParse(json['approvedDate'])
          : null,
      rejectedBy: json['rejectedBy'],
      rejectedDate: json['rejectedDate'] != null
          ? DateTime.tryParse(json['rejectedDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'employeeName': employeeName,
      'date': date.toIso8601String(),
      'status': status,
      'approvedBy': approvedBy,
      'approvedDate': approvedDate?.toIso8601String(),
      'rejectedBy': rejectedBy,
      'rejectedDate': rejectedDate?.toIso8601String(),
    };
  }
}
