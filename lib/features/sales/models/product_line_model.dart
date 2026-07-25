class ProductLineModel {
  final String productName;
  final int quantity;
  final double unitPrice;
  final double taxes;
  final int availableQty;

  ProductLineModel({
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.taxes,
    required this.availableQty,
  });

  double get subtotal => (quantity * unitPrice) + taxes;
}
