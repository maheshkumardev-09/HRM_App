class DocumentsModel {
  final String id;
  final String name;
  final DateTime createdDate;
  final String downloadUrl;

  DocumentsModel({
    required this.createdDate,
    required this.id,
    required this.name,
    required this.downloadUrl,
  });
  factory DocumentsModel.fromJson(Map<String, dynamic> json) {
    return DocumentsModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      createdDate:
          DateTime.tryParse(json['createdDate'] ?? '') ?? DateTime.now(),
      downloadUrl: json['downloadUrl'] ?? '',
    );
  }
}
