import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/features/expenses/models/expense_model.dart';

class ExpensesController extends GetxController {
  RxBool isPaidByEmployee = false.obs;
  RxBool isPaidByCompany = false.obs;

  void selectEmployee(bool value) {
    isPaidByEmployee.value = value;
    if (value) {
      isPaidByCompany.value = false;
    }
  }

  void selectCompany(bool value) {
    isPaidByCompany.value = value;
    if (value) {
      isPaidByEmployee.value = false;
    }
  }

  final List<ExpenseModel> expensesList = [
    ExpenseModel(
      amount: 300.00,
      description: 'Paid lunch bill for client',
      date: '2026-04-01',
      paidBy: 'Employee',
      status: 'Draft',
    ),
    ExpenseModel(
      amount: 150.00,
      description: 'Other Expense',
      date: '2026-04-10',
      paidBy: 'Company',
      status: 'To Report',
    ),

    ExpenseModel(
      amount: 1150.00,
      description: 'Office Expenses',
      date: '2026-04-10',
      paidBy: 'Company',
      status: 'Submitted',
    ),

    ExpenseModel(
      amount: 300.00,
      description: 'Paid lunch bill for client',
      date: '2026-04-01',
      paidBy: 'Employee',
      status: 'Approved',
    ),

    ExpenseModel(
      amount: 300.00,
      description: 'Paid lunch bill for client',
      date: '2026-04-01',
      paidBy: 'Employee',
      status: 'Paid',
    ),

    ExpenseModel(
      amount: 1150.00,
      description: 'Office Expenses',
      date: '2026-04-10',
      paidBy: 'Company',
      status: 'Cancelled',
    ),
  ].obs;
  final List<String> statusList = [
    'All States',
    'To Report',
    'Submitted',
    'Approved',
    'Paid',
    'Draft',
    'Concelled',
  ].obs;
  final selectedStatus = 'All States'.obs;
  Color getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;

      case 'Submitted':
        return Colors.blue;

      case 'Paid':
        return Colors.purple;

      case 'To Report':
        return Colors.orange;

      case 'Draft':
        return Colors.grey;

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
