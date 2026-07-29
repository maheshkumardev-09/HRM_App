import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/features/sales/controllers/sales_controller.dart';
import 'package:hrm_app/features/sales/models/product_line_model.dart';
import 'package:hrm_app/features/sales/models/sales_model.dart';
import 'package:intl/intl.dart';

class QuotationController extends GetxController {
  final customerController = TextEditingController();
  final dateController = TextEditingController();
  final RxList<Map<String, TextEditingController>> productControllers =
      <Map<String, TextEditingController>>[
        {
          'product': TextEditingController(),
          'quantity': TextEditingController(),
          'unitPrice': TextEditingController(),
          'taxes': TextEditingController(),
          'availableQty': TextEditingController(),
          'subtotal': TextEditingController(),
        },
      ].obs;
  void addProductLine() {
    productControllers.add({
      'product': TextEditingController(),
      'quantity': TextEditingController(),
      'unitPrice': TextEditingController(),
      'taxes': TextEditingController(),
      'availableQty': TextEditingController(),
      'subtotal': TextEditingController(),
    });
  }

  void removeProductLine(int index) {
    productControllers.removeAt(index);
  }

  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      dateController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  SalesModel _buildSalesModel() {
    final products = productControllers.map((ctrl) {
      return ProductLineModel(
        productName: ctrl['product']!.text,
        quantity: int.tryParse(ctrl['quantity']!.text) ?? 0,
        unitPrice: double.tryParse(ctrl['unitPrice']!.text) ?? 0,
        taxes: double.tryParse(ctrl['taxes']!.text) ?? 0,
        availableQty: int.tryParse(ctrl['availableQty']!.text) ?? 0,
      );
    }).toList();
    return SalesModel(
      clientName: customerController.text,
      status: 'Quotation',
      date: DateFormat('dd/MM/yyyy').parse(dateController.text),
      products: products,
    );
  }

  void createQuotation() {
    final salesController = Get.find<SalesController>();
    salesController.addQuotation(_buildSalesModel());
    Get.back();
  }

  void updateQuotation(int index) {
    final salesController = Get.find<SalesController>();
    salesController.updateQuotation(index, _buildSalesModel());
    Get.back();
  }

  void loadExistingData(SalesModel sale) {
    customerController.text = sale.clientName;
    dateController.text = DateFormat('dd/MM/yyyy').format(sale.date);

    productControllers.clear();
    for (var product in sale.products) {
      productControllers.add({
        'product': TextEditingController(text: product.productName),
        'quantity': TextEditingController(text: product.quantity.toString()),
        'unitPrice': TextEditingController(text: product.unitPrice.toString()),
        'taxes': TextEditingController(text: product.taxes.toString()),
        'availableQty': TextEditingController(
          text: product.availableQty.toString(),
        ),
        'subtotal': TextEditingController(text: product.subtotal.toString()),
      });
    }
  }

  // 🔹 Naya function — index-based, kyunki multiple products hain
  void calculateSubtotal(int index) {
    final ctrl = productControllers[index];

    final qty = double.tryParse(ctrl['quantity']!.text) ?? 0;
    final price = double.tryParse(ctrl['unitPrice']!.text) ?? 0;
    final tax = double.tryParse(ctrl['taxes']!.text) ?? 0;

    final subtotal = (qty * price) + tax;

    // 🔹 Agar 'subtotal' controller pehle se list mein nahi hai, add karein
    if (!ctrl.containsKey('subtotal')) {
      ctrl['subtotal'] = TextEditingController();
    }

    ctrl['subtotal']!.text = 'SR ${subtotal.toStringAsFixed(2)}';

    productControllers.refresh(); // ✅ UI ko force update karo
  }

  @override
  void onClose() {
    customerController.dispose();
    dateController.dispose();
    for (var ctrl in productControllers) {
      for (var c in ctrl.values) {
        c.dispose();
      }
    }
    super.onClose();
  }
}
