import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/features/expenses/data/expanse_dummy_data.dart';
import 'package:hrm_app/features/expenses/models/expense_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpensesController extends GetxController {
  RxList<ExpenseModel> expenses = <ExpenseModel>[].obs;
  ExpenseModel? editingExpense;
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();
  final noteController = TextEditingController();
  RxString selectedExpenseType = "".obs;
  RxBool isLoading = false.obs;
  Rx<File?> selectedFile = Rx<File?>(null);
  RxBool isPaidByEmployee = false.obs;
  RxBool isPaidByCompany = false.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final selectedStatus = 'All States'.obs;

  List<String> expenseType = [
    'Meal & Food',
    'Travel',
    'Accommodation',
    'Airfare',
    'Other',
  ];
  final List<String> statusList = [
    'All States',
    'To Report',
    'Submitted',
    'Approved',
    'Paid',
    'Draft',
    'Cancelled',
  ].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  void onClose() {
    descriptionController.dispose();
    amountController.dispose();
    noteController.dispose();
    super.onClose();
  }

  void startEdit(ExpenseModel expense) {
    editingExpense = expense;

    descriptionController.text = expense.description;

    amountController.text = expense.amount.toString();

    selectedExpenseType.value = expense.expenseType;
  }

  void clearForm() {
    editingExpense = null;
    descriptionController.clear();
    amountController.clear();
    selectedExpenseType.value = "";
    isPaidByEmployee.value = false;
    isPaidByCompany.value = false;
    noteController.clear();
    selectedFile.value = null;
    selectedDate.value = null;
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String? expanlist = prefs.getString("expenses");
    if (expanlist == null) {
      expenses.value = ExpanseDummyData.expensesList
          .map((e) => ExpenseModel.fromJson(e))
          .toList();
      await saved();
    } else {
      List data = jsonDecode(expanlist);
      expenses.value = data.map((e) => ExpenseModel.fromJson(e)).toList();
    }
  }

  Future<void> addNewExpenses() async {
    if (selectedExpenseType.value.isEmpty ||
        amountController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty ||
        (!isPaidByCompany.value && !isPaidByEmployee.value)) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }
    final newExpen = ExpenseModel(
      amount: double.tryParse(amountController.text) ?? 00,
      date: DateTime.now(),
      paidBy: isPaidByCompany.value ? 'Company' : 'Employee',
      status: 'Draft',
      description: descriptionController.text,
      expenseType: selectedExpenseType.value,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    isLoading.value = true;
    expenses.add(newExpen);
    await saved();
    isLoading.value = false;
    clearForm();
    Get.back();
    Get.snackbar('Success', 'New Expenses added');
  }

  Future<void> updateExpense() async {
    if (editingExpense == null) {
      Get.snackbar("Error", "Expense not found");
      return;
    }
    final index = expenses.indexWhere((e) => e.id == editingExpense!.id);
    if (index == -1) {
      Get.snackbar("Error", "Expense not found");
      return;
    }
    expenses[index] = ExpenseModel(
      id: editingExpense!.id,
      amount: double.tryParse(amountController.text) ?? 0,
      date: editingExpense!.date,
      paidBy: isPaidByCompany.value ? "Company" : "Employee",
      status: editingExpense!.status,
      description: descriptionController.text,
      expenseType: selectedExpenseType.value,
    );
    await saved();
    expenses.refresh();
    clearForm();
    Get.back();
    Get.snackbar("Updated", "Expense updated successfully");
  }

  Future<void> removeExpense(ExpenseModel expense) async {
    expenses.remove(expense);
    await saved();
    Get.snackbar("Deleted", "Expense removed successfully");
  }

  Future<void> saved() async {
    final prefs = await SharedPreferences.getInstance();
    final data = expenses.map((e) => e.toJson()).toList();
    await prefs.setString("expenses", jsonEncode(data));
  }

  void changeStatus(String value) {
    selectedStatus.value = value;
  }

  List<ExpenseModel> get filteredExpenses {
    if (selectedStatus.value == "All States") {
      return expenses;
    }

    return expenses.where((e) => e.status == selectedStatus.value).toList();
  }

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
        return AppColors.primaryColor;
    }
  }

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

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf", "png", "jpg", "jpeg"],
    );
    if (result != null) {
      selectedFile.value = File(result.files.single.path!);
    }
  }

  void showDeleteDialog(ExpenseModel expense) {
    Get.defaultDialog(
      title: "Delete Expense",
      middleText: "Are you sure you want to delete this expense?",

      textCancel: "Cancel",
      textConfirm: "Delete",

      onCancel: () {
        Get.back();
      },

      onConfirm: () async {
        await removeExpense(expense);
        Get.back();
      },
    );
  }
}
