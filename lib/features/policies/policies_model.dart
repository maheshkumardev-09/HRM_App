class PoliciesModel {
  final String id;
  final String title;
  final String companyName;
  final String pdfUrl;

  PoliciesModel({
    required this.id,
    required this.title,
    required this.companyName,
    required this.pdfUrl,
  });

  factory PoliciesModel.fromJson(Map<String, dynamic> json) {
    return PoliciesModel(
      id: json['id'] as String,
      title: json['title'] as String,
      companyName: json['description'] as String,
      pdfUrl: json['pdfUrl'] as String,
    );
  }
}
