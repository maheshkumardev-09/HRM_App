import 'package:hrm_app/features/sales/models/product_line_model.dart';

class SalesModel {
  final String clientName;
  final String status;
  final DateTime date;
  final List<ProductLineModel> products;
  SalesModel({
    required this.clientName,
    required this.status,
    required this.date,
    required this.products,
  });
  int get amount =>
      products.fold(0, (sum, item) => sum + item.subtotal.toInt());
}
