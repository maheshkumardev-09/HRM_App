class ExpenseModel {
  final String id;
  final double amount;
  final String description;
  final DateTime date;
  final String paidBy;
  final String status;
  final String? note;
  final String expenseType;
  final String? receiptPath;
  final String employeeId;
  final String employeeName;

  ExpenseModel({
    required this.amount,
    required this.date,
    required this.paidBy,
    required this.status,
    required this.description,
    this.note,
    required this.expenseType,
    required this.id,
    this.receiptPath,
    required this.employeeId,
    required this.employeeName,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json["id"] ?? '',
      amount: (json["amount"] as num?)?.toDouble() ?? 0.0,
      date: json["date"] != null
          ? DateTime.parse(json["date"])
          : DateTime.now(),
      paidBy: json["paidBy"] ?? '',
      status: json["status"] ?? '',
      description: json["description"] ?? '',
      note: json["note"],
      expenseType: json["expenseType"] ?? '',
      receiptPath: json["receiptPath"],
      employeeId: json["employeeId"] ?? '',
      employeeName: json["employeeName"] ?? '',
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
      "expenseType": expenseType,
      "receiptPath": receiptPath,
      "employeeId": employeeId,
      "employeeName": employeeName,
    };
  }
}
