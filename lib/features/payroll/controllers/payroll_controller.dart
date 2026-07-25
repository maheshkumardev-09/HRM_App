import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:hrm_app/features/payroll/models/payroll_model.dart';

class PayrollController extends GetxController {
  final List<PayrollModel> payrollList = [
    PayrollModel(
      id: "001",
      dateFrom: "2026-01-01",
      dateTo: "2026-01-31",
      status: "Paid",
      payment: 50000.0,
    ),

    PayrollModel(
      id: "002",
      dateFrom: "2026-02-01",
      dateTo: "2026-02-28",
      status: "Pending",
      payment: 50000.0,
    ),

    PayrollModel(
      id: "003",
      dateFrom: "2026-03-01",
      dateTo: "2026-03-31",
      status: "Approved",
      payment: 55000.0,
    ),

    PayrollModel(
      id: "004",
      dateFrom: "2026-04-01",
      dateTo: "2026-04-30",
      status: "Draft",
      payment: 52000.0,
    ),

    PayrollModel(
      id: "005",
      dateFrom: "2026-05-01",
      dateTo: "2026-05-31",
      status: "Cancelled",
      payment: 48000.0,
    ),
  ].obs;
  final RxList<String> statusList = <String>[
    'Paid',
    "Pending",
    "Approved",
    'Draft',
    'Cancelled',
  ].obs;
  final selectedStatus = 'All States'.obs;

  Color getStatusColor(String status) {
    switch (status) {
      case 'Paid':
        return Colors.green;

      case 'Submitted':
        return Colors.blue;

      case "Pending":
        return Colors.amber;

      case 'Draft':
        return Colors.deepPurple;

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
