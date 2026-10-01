class LeadNoteModel {
  final String authorName;
  final String note;
  final DateTime date;

  LeadNoteModel({
    required this.authorName,
    required this.note,
    required this.date,
  });

  factory LeadNoteModel.fromJson(Map<String, dynamic> json) {
    return LeadNoteModel(
      authorName: json['authorName'] ?? '',
      note: json['note'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'authorName': authorName,
      'note': note,
      'date': date.toIso8601String(),
    };
  }
}
