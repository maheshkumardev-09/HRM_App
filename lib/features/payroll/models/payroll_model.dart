class PayrollModel {
  final String id;
  final String dateFrom;
  final String dateTo;
  // final String month;
  final String status;
  final double payment;
  // final String pdfUrl;
  PayrollModel({
    required this.status,
    required this.payment,
    required this.id,
    required this.dateFrom,
    required this.dateTo,
    // required this.month,
    // required this.pdfUrl,
  });
}
