import 'package:hrm_app/features/sales/models/products_model.dart';

class SalesModel {
  final String clientName;
  final String status;
  final DateTime date;
  final List<ProducttseModel> products;
  SalesModel({
    required this.clientName,
    required this.status,
    required this.date,
    required this.products,
  });
  int get amount =>
      products.fold(0, (sum, item) => sum + item.subtotal.toInt());
  factory SalesModel.fromJson(Map<String, dynamic> json) {
    return SalesModel(
      clientName: json['clientName']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      date: DateTime.tryParse(json['date']?.toString() ?? '') ?? DateTime.now(),
      products: (json['products'] as List<dynamic>? ?? [])
          .map((p) => ProducttseModel.fromJson(p as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientName': clientName,
      'status': status,
      'date': date.toIso8601String().split('T').first,
      'products': products.map((p) => p.toJson()).toList(),
    };
  }

  // Parse a full list of sales records (e.g. from sales_data.json)
  static List<SalesModel> listFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((e) => SalesModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
