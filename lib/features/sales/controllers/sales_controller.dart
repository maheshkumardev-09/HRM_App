import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/features/sales/models/sales_model.dart';

class SalesController extends GetxController {
  final List<SalesModel> salesList = [
    SalesModel(
      clientName: "Ahmed Ali",
      status: 'Salels Order',
      date: DateTime(2026, 7, 20),
      amount: 25000,
    ),
    SalesModel(
      clientName: "Sara Khan",
      status: 'Quotation Sent',
      date: DateTime(2026, 7, 18),
      amount: 18000,
    ),
    SalesModel(
      clientName: "Usman Sheikh",
      status: 'Quotation',
      date: DateTime(2026, 7, 15),
      amount: 32000,
    ),
    SalesModel(
      clientName: "Fatima Noor",
      status: 'Salels Order',
      date: DateTime(2026, 7, 10),
      amount: 15000,
    ),
    SalesModel(
      clientName: "Bilal Ahmed",
      status: "Cancelled",
      date: DateTime(2026, 7, 5),
      amount: 28000,
    ),
  ].obs;
  final List<String> statusList = [
    'All States',
    'Quotation',
    'Quotation Sent',
    'Salels Order',
    'Concelled',
  ].obs;
  final selectedStatus = 'All States'.obs;
  Color getStatusColor(String status) {
    switch (status) {
      case 'Quotation':
        return Colors.purple;
      case 'Quotation Sent':
        return Colors.orange;
      case 'Salels Order':
        return Colors.purple;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.black54;
    }
  }

  void changeStatus(String value) {
    selectedStatus.value = value;
  }
}
