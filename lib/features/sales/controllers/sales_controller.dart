import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/features/sales/data/sales_dummy_data.dart';
import 'package:hrm_app/features/sales/models/sales_model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalesController extends GetxController {
  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();
  final salesList = <SalesModel>[].obs;
  final filterSales = <SalesModel>[].obs;
  List<String> ProdectNames = [
    'Product A',
    'Product B',
    'Product C',
    'Product D',
    'Product E',
    'Product F',
    'Product G',
  ];
  final List<String> statusList = [
    'All States',
    'Quotation',
    'Quotation Sent',
    'Sales Order',
    'Cancelled',
  ].obs;
  final selectedStatus = 'All States'.obs;
  DateTime? fromDate;

  DateTime? toDate;
  @override
  void onInit() {
    _init();
    super.onInit();
  }

  @override
  void onClose() {
    fromDateController.dispose();
    toDateController.dispose();
    super.onClose();
  }

  Future<void> _init() async {
    await loadData();
    filterSales.assignAll(salesList);
  }

  Future<void> loadData() async {
    final pres = await SharedPreferences.getInstance();
    final data = pres.getString('saleslist');

    if (data == null) {
      salesList.value = SalesDummyData.salesList
          .map((e) => SalesModel.fromJson(e))
          .toList();
    } else {
      List list = jsonDecode(data);
      salesList.value = list.map((e) => SalesModel.fromJson(e)).toList();
    }
  }

  Future<void> save() async {
    final pres = await SharedPreferences.getInstance();
    final data = salesList.map((e) => e.toJson()).toList();
    await pres.setString('saleslist', jsonEncode(data));
  }

  void changeStatus(String value) {
    selectedStatus.value = value;
    applyFilters();
  }

  void changeDateRange(DateTime? start, DateTime? end) {
    fromDate = start;
    toDate = end;
    applyFilters();
  }

  void applyFilters() {
    filterSales.assignAll(
      salesList.where((sales) {
        final stausMatch =
            selectedStatus.value == 'All States' ||
            sales.status == selectedStatus.value;

        final dateMatch =
            (fromDate == null || !sales.date.isBefore(fromDate!)) &&
            (toDate == null || !sales.date.isAfter(toDate!));
        return stausMatch && dateMatch;
      }).toList(),
    );
  }

  Future<void> pickFromDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: fromDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null) {
      fromDate = picked;
      fromDateController.text = DateFormat('dd/MM/yyyy').format(picked);
      applyFilters();
    }
  }

  Future<void> pickToDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: toDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null) {
      toDate = picked;
      toDateController.text = DateFormat('dd/MM/yyyy').format(picked);
      applyFilters();
    }
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
    applyFilters();
    save();
  }

  void updateQuotation(int index, SalesModel updatedSale) {
    salesList[index] = updatedSale;
    save();
    applyFilters();
  }

  void clearFilters() {
    selectedStatus.value = 'All States';
    fromDate = null;
    toDate = null;
    filterSales.assignAll(salesList);
  }
}
