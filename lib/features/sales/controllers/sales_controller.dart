import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/features/sales/models/product_line_model.dart';
import 'package:hrm_app/features/sales/models/sales_model.dart';

class SalesController extends GetxController {
  final List<SalesModel> salesList = [
    SalesModel(
      clientName: "Ahmed Ali",
      status: 'Sales Order',
      date: DateTime(2026, 7, 20),
      products: [
        ProductLineModel(
          productName: 'Product A',
          quantity: 5,
          unitPrice: 5000,
          taxes: 0,
          availableQty: 10,
        ),
      ],
    ),
    SalesModel(
      clientName: "Sara Khan",
      status: 'Quotation Sent',
      date: DateTime(2026, 7, 18),
      products: [
        ProductLineModel(
          productName: 'Product B',
          quantity: 2,
          unitPrice: 2000,
          taxes: 100,
          availableQty: 2,
        ),
      ],
    ),
    SalesModel(
      clientName: "Usman Sheikh",
      status: 'Quotation',
      date: DateTime(2026, 7, 15),
      products: [
        ProductLineModel(
          productName: 'Product c',
          quantity: 4,
          unitPrice: 2500,
          taxes: 80,
          availableQty: 4,
        ),
      ],
    ),
    SalesModel(
      clientName: "Fatima Noor",
      status: 'Sales Order',
      date: DateTime(2026, 7, 10),
      products: [
        ProductLineModel(
          productName: 'Product d',
          quantity: 5,
          unitPrice: 2300,
          taxes: 150,
          availableQty: 5,
        ),
      ],
    ),
    SalesModel(
      clientName: "Bilal Ahmed",
      status: 'Cancelled',
      date: DateTime(2026, 7, 5),
      products: [
        ProductLineModel(
          productName: 'Product E',
          quantity: 3,
          unitPrice: 2050,
          taxes: 160,
          availableQty: 3,
        ),
      ],
    ),
  ].obs;
  final List<String> statusList = [
    'All States',
    'Quotation',
    'Quotation Sent',
    'Sales Order',
    'Cancelled',
  ].obs;
  final selectedStatus = 'All States'.obs;
  void changeStatus(String value) {
    selectedStatus.value = value;
  }

  List<SalesModel> get filteredSalesList {
    if (selectedStatus.value == 'All States') return salesList;
    return salesList
        .where((sale) => sale.status == selectedStatus.value)
        .toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Quotation':
        return Colors.purple;
      case 'Quotation Sent':
        return Colors.orange;
      case 'Sales Order':
        return Colors.purple;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.black54;
    }
  }

  void addQuotation(SalesModel sale) {
    salesList.add(sale);
  }

  void updateQuotation(int index, SalesModel updatedSale) {
    salesList[index] = updatedSale;
  }
}
