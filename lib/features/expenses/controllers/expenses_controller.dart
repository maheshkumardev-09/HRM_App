import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/features/expenses/data/expanse_dummy_data.dart';
import 'package:hrm_app/features/expenses/models/expense_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpensesController extends GetxController {
  RxBool isLoading = false.obs;
  RxString selectedExpenseType = "".obs;
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();
  final noteController = TextEditingController();
  Rx<File?> selectedFile = Rx<File?>(null);
  RxBool isPaidByEmployee = false.obs;
  RxBool isPaidByCompany = false.obs;
  RxList<ExpenseModel> expenselist = <ExpenseModel>[].obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  ExpenseModel? selectedExpense;

  @override
  void onInit() {
    super.onInit();

    loadData();
    selectedExpense = Get.arguments;
    if (selectedExpense != null) {
      loadExpenseData();
    }
  }

  List<String> expenseType = [
    'Meal & Food',
    'Travel',
    'Accommodation',
    'Airfare',
    'other',
  ];
  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String? expanlist = prefs.getString("expenses");
    if (expanlist == null) {
      expenselist.value = ExpanseDummyData.expensesList
          .map((e) => ExpenseModel.fromJson(e))
          .toList();
      await saved();
    } else {
      List data = jsonDecode(expanlist);
      expenselist.value = data.map((e) => ExpenseModel.fromJson(e)).toList();
    }
  }

  Future<void> saved() async {
    final prefs = await SharedPreferences.getInstance();
    final data = expenselist.map((e) => e.toJson()).toList();
    await prefs.setString("expenses", jsonEncode(data));
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

  final List<String> statusList = [
    'All States',
    'To Report',
    'Submitted',
    'Approved',
    'Paid',
    'Draft',
    'Cancelled',
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

  List<ExpenseModel> get filteredExpenses {
    if (selectedStatus.value == "All States") {
      return expenselist;
    }

    return expenselist.where((e) => e.status == selectedStatus.value).toList();
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

  void loadExpenseData() {
    descriptionController.text = selectedExpense!.description;
    amountController.text = selectedExpense!.amount.toString();
    selectedExpenseType.value = selectedExpense!.expenseType;

    if (selectedExpense!.paidBy == "Company") {
      isPaidByCompany.value = true;
      isPaidByEmployee.value = false;
    } else {
      isPaidByEmployee.value = true;
      isPaidByCompany.value = false;
    }
  }

  Future<void> updateExpense() async {
    print("Update Start");

    final index = expenselist.indexWhere(
      (e) =>
          e.description == selectedExpense!.description &&
          e.date == selectedExpense!.date,
    );

    if (index != -1) {
      expenselist[index] = ExpenseModel(
        amount: double.tryParse(amountController.text) ?? 0,
        date: selectedExpense!.date,
        paidBy: isPaidByCompany.value ? "Company" : "Employee",
        status: selectedExpense!.status,
        description: descriptionController.text,
        expenseType: selectedExpenseType.value,
      );
      await saved();
      expenselist.refresh();
      Get.back();

      Get.snackbar("Updated", "Expense updated successfully");
    } else {}
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
    );
    expenselist.add(newExpen);
    isLoading.value = true;
    await saved();
    isLoading.value = false;
    amountController.clear();
    descriptionController.clear();
    selectedExpenseType.value = '';
    noteController.clear();
    isPaidByCompany.value = false;
    isPaidByEmployee.value = false;
    Get.back();
    Get.snackbar('Success', 'New Expenses added');
  }

  Future<void> removeExpense(ExpenseModel expense) async {
    expenselist.remove(expense);
    await saved();
    Get.snackbar("Deleted", "Expense removed successfully");
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
