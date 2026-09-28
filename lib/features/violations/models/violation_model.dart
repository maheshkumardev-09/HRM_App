class ViolationModel {
  final String id;
  final String category; 
  final String title; 
  final String employeeName;
  final DateTime date;
  final String status;
  final String actionTaken;
  final int occurrences;
  final double deductionPercent;
  final double deductionAmount;
  final DateTime? deductionEffectiveDate;
  final String? notice;

  ViolationModel({
    required this.id,
    required this.category,
    required this.title,
    required this.employeeName,
    required this.date,
    required this.status,
    required this.actionTaken,
    required this.occurrences,
    required this.deductionPercent,
    required this.deductionAmount,
    this.deductionEffectiveDate,
    this.notice,
  });

  factory ViolationModel.fromJson(Map<String, dynamic> json) {
    return ViolationModel(
      id: json['id'] ?? '',
      category: json['category'] ?? '',
      title: json['title'] ?? '',
      employeeName: json['employeeName'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      status: json['status'] ?? 'Pending',
      actionTaken: json['actionTaken'] ?? '',
      occurrences: json['occurrences'] ?? 0,
      deductionPercent: (json['deductionPercent'] ?? 0).toDouble(),
      deductionAmount: (json['deductionAmount'] ?? 0).toDouble(),
      deductionEffectiveDate: json['deductionEffectiveDate'] != null
          ? DateTime.tryParse(json['deductionEffectiveDate'])
          : null,
      notice: json['notice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'title': title,
      'employeeName': employeeName,
      'date': date.toIso8601String(),
      'status': status,
      'actionTaken': actionTaken,
      'occurrences': occurrences,
      'deductionPercent': deductionPercent,
      'deductionAmount': deductionAmount,
      'deductionEffectiveDate': deductionEffectiveDate?.toIso8601String(),
      'notice': notice,
    };
  }
}
