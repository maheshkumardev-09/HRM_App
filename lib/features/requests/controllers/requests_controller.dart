import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/features/auth/controllers/auth_controller.dart';
import 'package:hrm_app/features/requests/data/request_dummy_data.dart';
import 'package:hrm_app/features/requests/data/request_type_dummy_data.dart';
import 'package:hrm_app/features/requests/models/request_model.dart';
import 'package:hrm_app/features/requests/models/request_type_model.dart';
import 'package:hrm_app/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestsController extends GetxController {
  final List<RequestTypeModel> requestTypes = RequestTypeDummyData.types;
  final RxString searchQuery = ''.obs;
  final searchController = TextEditingController();
  final RxString selectedRequestType = ''.obs;
  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();
  Rx<File?> selectedFile = Rx<File?>(null);
  RxBool isLoading = false.obs;
  Rx<DateTime?> selectedExtraDate = Rx<DateTime?>(null);

  List<RequestTypeModel> get filteredRequestTypes {
    if (searchQuery.value.trim().isEmpty) return requestTypes;
    final query = searchQuery.value.trim().toLowerCase();
    return requestTypes
        .where((type) => type.title.toLowerCase().contains(query))
        .toList();
  }

  void updateSearch(String value) {
    searchQuery.value = value;
  }

  void selectRequestType(String title) {
    selectedRequestType.value = title;
  }

  RxList<RequestModel> requestList = <RequestModel>[].obs;
  Rx<DateTime?> filterDateFrom = Rx<DateTime?>(null);
  Rx<DateTime?> filterDateTo = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  void onClose() {
    searchController.dispose();
    subjectController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('requestsList');
    if (data == null) {
      requestList.value = RequestDummyData.requests
          .map((r) => RequestModel.fromJson(r))
          .toList();
    } else {
      List decoded = jsonDecode(data);
      requestList.value = decoded.map((e) => RequestModel.fromJson(e)).toList();
    }
    isLoading.value = false;
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = requestList.map((e) => e.toJson()).toList();
    await prefs.setString('requestsList', jsonEncode(data));
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

  Future<void> submitRequest({
    Map<String, String> extraFields = const {},
  }) async {
    if (selectedRequestType.value.isEmpty ||
        subjectController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }
    final auth = Get.find<AuthController>();
    final now = DateTime.now();
    final newRequest = RequestModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      requestType: selectedRequestType.value,
      subject: subjectController.text.trim(),
      description: descriptionController.text.trim(),
      status: 'Pending',
      attachmentPath: selectedFile.value?.path,
      employeeId: auth.currentUser.value?.id ?? '',
      employeeName: auth.currentUser.value?.name ?? '',
      startDate: now,
      endDate: now,
      extraFields: extraFields,
    );
    requestList.add(newRequest);
    await saveData();
    clearForm();
    Get.toNamed(AppRoutes.requestsview);
    Get.snackbar('Success', 'Request submitted successfully');
  }

  void clearForm() {
    selectedRequestType.value = '';
    subjectController.clear();
    descriptionController.clear();
    selectedFile.value = null;
    selectedExtraDate.value = null;
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

  Future<void> pickExtraDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      selectedExtraDate.value = picked;
    }
  }

  void clearDateFilter() {
    filterDateFrom.value = null;
    filterDateTo.value = null;
  }

  List<RequestModel> get filteredRequests {
    var list = requestList.toList();
    if (filterDateFrom.value != null) {
      list = list
          .where((e) => !e.startDate.isBefore(filterDateFrom.value!))
          .toList();
    }
    if (filterDateTo.value != null) {
      list = list
          .where((e) => !e.startDate.isAfter(filterDateTo.value!))
          .toList();
    }
    return list;
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      case 'Pending':
      default:
        return Colors.orange;
    }
  }

  RequestModel? getRequestById(String id) {
    return requestList.firstWhereOrNull((r) => r.id == id);
  }

  Future<void> removeRequest(RequestModel request) async {
    requestList.removeWhere((e) => e.id == request.id);
    await saveData();
    Get.snackbar("Deleted", "Request removed successfully");
  }

  void showDeleteDialog(RequestModel request) {
    Get.defaultDialog(
      title: "Delete Request",
      middleText: "Are you sure you want to delete this request?",
      textCancel: "Cancel",
      textConfirm: "Delete",
      onCancel: () {
        Get.back();
      },
      onConfirm: () async {
        await removeRequest(request);
        Get.back();
      },
    );
  }
}
