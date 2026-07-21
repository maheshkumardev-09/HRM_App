class ExpenseModel {
  final double amount;
  final String description;
  final String date;
  final String paidBy;
  final String status;

  ExpenseModel({
    required this.amount,
    required this.date,
    required this.paidBy,
    required this.status,
    required this.description,
  });
}
