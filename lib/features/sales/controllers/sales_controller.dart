import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/features/sales/models/product_line_model.dart';
import 'package:hrm_app/features/sales/models/sales_model.dart';

class SalesController extends GetxController {
  final List<SalesModel> salesList = [
    SalesModel(
      clientName: "Ahmed Ali",
      status: 'Salels Order',
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
      products: [],
    ),
    SalesModel(
      clientName: "Usman Sheikh",
      status: 'Quotation',
      date: DateTime(2026, 7, 15),
      products: [],
    ),
    SalesModel(
      clientName: "Fatima Noor",
      status: 'Sales Order',
      date: DateTime(2026, 7, 10),
      products: [],
    ),
    SalesModel(
      clientName: "Bilal Ahmed",
      status: 'Cancelled',
      date: DateTime(2026, 7, 5),
      products: [],
    ),
  ].obs;
  final List<String> statusList = [
    'All States',
    'Quotation',
    'Quotation Sent',
    'Sales Order',
    'Cancelled',
  ];
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
