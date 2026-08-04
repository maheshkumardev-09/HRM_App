class ExpenseModel {
  final String id;
  final double amount;
  final String description;
  final DateTime date;
  final String paidBy;
  final String status;
  final String? note;
  final String expenseType;

  ExpenseModel({
    required this.amount,
    required this.date,
    required this.paidBy,
    required this.status,
    required this.description,
    this.note,
    required this.expenseType,
    required this.id,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      amount: json["amount"] ?? '',
      date: DateTime.parse(json["date"] ?? 0),
      paidBy: json["paidBy"] ?? '',
      status: json["status"] ?? '',
      description: json["description"] ?? '',
      note: json["note"],
      expenseType: json["expenseType"] ?? '',
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "amount": amount,
      "date": date.toIso8601String(),
      "paidBy": paidBy,
      "status": status,
      "description": description,
      "note": note,
      'expenseType': expenseType,
    };
  }
}
