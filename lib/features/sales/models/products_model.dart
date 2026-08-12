class ProducttseModel {
  final String productName;
  final int quantity;
  final double unitPrice;
  final double taxes;
  final int availableQty;

  ProducttseModel({
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.taxes,
    required this.availableQty,
  });

  double get subtotal => (quantity * unitPrice) + taxes;

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }

  factory ProducttseModel.fromJson(Map<String, dynamic> json) {
    return ProducttseModel(
      productName: json['productname']?.toString() ?? '',
      quantity: _parseInt(json['quantity']),
      unitPrice: _parseDouble(json['unitPrice']),
      taxes: _parseDouble(json['taxes']),
      availableQty: _parseInt(json['availableqty']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productname': productName,
      'quantity': quantity.toString(),
      'unitPrice': unitPrice.toString(),
      'taxes': taxes.toString(),
      'availableqty': availableQty.toString(),
    };
  }
}
