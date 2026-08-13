import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:hrm_app/features/payroll/data/patroll_dummy_data.dart';
import 'package:hrm_app/features/payroll/models/payroll_model.dart';
import 'package:hrm_app/services/payroll_services.dart';

class PayrollController extends GetxController {
  final payrollList = <PayrollModel>[
    ...PayrollDummyData.payroll.map((e) => PayrollModel.fromJson(e)),
  ].obs;

  Color statusColors(String status) {
    switch (status) {
      case 'Paid':
        return Colors.green;
      case "Pending":
        return Colors.amber;
      case 'Draft':
        return Colors.blue;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.black54;
    }
  }

  Future<void> payrollPdf(PayrollModel payroll) async {
    final success = await PayrollServices().createPayrollPdf(payroll);

    if (success) {
      Get.snackbar('Success', 'Payslip downloaded successfully');
    } else {
      Get.snackbar('Error', 'Failed to download payslip');
    }
  }
}
