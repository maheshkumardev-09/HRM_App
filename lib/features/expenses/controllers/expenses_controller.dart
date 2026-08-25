import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/features/auth/controllers/auth_controller.dart';
import 'package:hrm_app/features/expenses/data/expanse_dummy_data.dart';
import 'package:hrm_app/features/expenses/models/expense_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpensesController extends GetxController {
  Rx<DateTime?> filterDateFrom = Rx<DateTime?>(null);
  Rx<DateTime?> filterDateTo = Rx<DateTime?>(null);
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
    isPaidByCompany.value = expense.paidBy == 'Company';
    isPaidByEmployee.value = expense.paidBy == 'Employee';
    noteController.text = expense.note ?? '';
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
    final auth = Get.find<AuthController>();
    final amount = double.tryParse(amountController.text.trim());
    if (selectedExpenseType.value.isEmpty ||
        amount == null ||
        amount <= 0 ||
        descriptionController.text.trim().isEmpty ||
        (!isPaidByCompany.value && !isPaidByEmployee.value)) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }
    final newExpen = ExpenseModel(
      amount: amount,
      date: DateTime.now(),
      paidBy: isPaidByCompany.value ? 'Company' : 'Employee',
      status: 'Draft',
      description: descriptionController.text,
      expenseType: selectedExpenseType.value,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      note: noteController.text.trim(),
      receiptPath: selectedFile.value?.path,
      employeeId: auth.currentUser.value?.id ?? '',
      employeeName: auth.currentUser.value?.name ?? '',
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
    final amount = double.tryParse(amountController.text.trim());
    if (editingExpense == null) {
      Get.snackbar("Error", "Expense not found");
      return;
    }
    final index = expenses.indexWhere((e) => e.id == editingExpense!.id);
    if (index == -1) {
      Get.snackbar("Error", "Expense not found");
      return;
    }
    if (amount == null || amount <= 0) {
      Get.snackbar("Error", "Please enter a valid amount");
      return;
    }
    expenses[index] = ExpenseModel(
      id: editingExpense!.id,
      amount: amount,
      date: editingExpense!.date,
      paidBy: isPaidByCompany.value ? "Company" : "Employee",
      status: editingExpense!.status,
      description: descriptionController.text,
      expenseType: selectedExpenseType.value,
      receiptPath: selectedFile.value?.path ?? editingExpense!.receiptPath,
      employeeId: editingExpense!.employeeId,
      employeeName: editingExpense!.employeeName,
      note: noteController.text.trim(),
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
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf", "png", "jpg", "jpeg"],
    );
    if (result == null) return;
    final path = result.files.single.path;
    if (path == null) {
      Get.snackbar('Error', 'Unable to select file');
      return;
    }
    selectedFile.value = File(path);
  }

  Future<void> pickFilterDateFrom(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (picked != null) filterDateFrom.value = picked;
  }

  Future<void> pickFilterDateTo(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      if (filterDateFrom.value != null &&
          picked.isBefore(filterDateFrom.value!)) {
        Get.snackbar("Error", "To date cannot be before From date");
        return;
      }
      filterDateTo.value = picked;
    }
  }

  List<ExpenseModel> get filteredExpenses {
    var list = expenses.toList();
    if (selectedStatus.value != "All States") {
      list = list.where((e) => e.status == selectedStatus.value).toList();
    }
    if (filterDateFrom.value != null) {
      list = list
          .where((e) => !e.date.isBefore(filterDateFrom.value!))
          .toList();
    }
    if (filterDateTo.value != null) {
      list = list.where((e) => !e.date.isAfter(filterDateTo.value!)).toList();
    }
    return list;
  }

  void clearDateFilter() {
    filterDateFrom.value = null;
    filterDateTo.value = null;
    selectedStatus.value = 'All States';
  }

  void removeReceipt() {
    selectedFile.value = null;
    if (editingExpense != null) {
      editingExpense = ExpenseModel(
        id: editingExpense!.id,
        amount: editingExpense!.amount,
        date: editingExpense!.date,
        paidBy: editingExpense!.paidBy,
        status: editingExpense!.status,
        description: editingExpense!.description,
        expenseType: editingExpense!.expenseType,
        note: editingExpense!.note,
        receiptPath: null, // <-- receipt clear ho gaya
        employeeId: editingExpense!.employeeId,
        employeeName: editingExpense!.employeeName,
      );
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
}
