class PayrollModel {
  final String id;
  final DateTime dateFrom;
  final DateTime dateTo;
  // final String month;
  final String status;
  final double payment;
  // final String pdfUrl;
  PayrollModel({
    required this.id,
    required this.status,
    required this.payment,
    required this.dateFrom,
    required this.dateTo,
    // required this.month,
    // required this.pdfUrl,
  });

  factory PayrollModel.fromJson(Map<String, dynamic> json) {
    return PayrollModel(
      id: json['id'],
      status: json['status'],
      payment: (json['payment'] as num).toDouble(),
      dateFrom: DateTime.parse(json['dateFrom']),
      dateTo: DateTime.parse(json['dateTo']),
    );
  }

  Map<String, dynamic> json() {
    return {
      'id': id,
      'status': status,
      "payment": payment.toString(),
      'dateFrom': dateFrom.toIso8601String(),
      'dateTo': dateTo.toIso8601String(),
    };
  }
}
