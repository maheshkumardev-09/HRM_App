import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/features/auth/controllers/auth_controller.dart';
import 'package:hrm_app/features/crm/data/lead_dummy_data.dart';
import 'package:hrm_app/features/crm/models/lead_model.dart';
import 'package:hrm_app/features/crm/models/lead_note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CrmController extends GetxController {
  RxList<LeadModel> leadsList = <LeadModel>[].obs;

  final leadNameController = TextEditingController();
  final customerController = TextEditingController();
  final revenueController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final descriptionController = TextEditingController();
  final noteController = TextEditingController();
  RxString selectedStage = 'All Stages'.obs;
  RxString editStage = 'New'.obs;
  List<String> stageOptions = [
    'All Stages',
    'New',
    'Qualified',
    'Sent Proposal',
    'Proposition',
    'Won',
  ];
  List<String> editStageOptions = [
    'New',
    'Qualified',
    'Sent Proposal',
    'Proposition',
    'Won',
  ];
  Rx<DateTime?> filterDateFrom = Rx<DateTime?>(null);
  Rx<DateTime?> filterDateTo = Rx<DateTime?>(null);
  final customerFilterController = TextEditingController();
  final RxString customerFilterQuery = ''.obs;
  @override
  void onInit() {
    super.onInit();
    loadLeads();
  }

  @override
  void onClose() {
    leadNameController.dispose();
    customerController.dispose();
    revenueController.dispose();
    emailController.dispose();
    phoneController.dispose();
    descriptionController.dispose();
    customerFilterController.dispose();
    noteController.dispose();
    super.onClose();
  }

  Future<void> loadLeads() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('leadsList');
    if (data == null) {
      // pehli dafa — dummy data se shuru karo
      leadsList.value = LeadDummyData.leads;
    } else {
      List decoded = jsonDecode(data);
      leadsList.value = decoded.map((e) => LeadModel.fromJson(e)).toList();
    }
  }

  Future<void> saveLeads() async {
    final prefs = await SharedPreferences.getInstance();
    final data = leadsList.map((e) => e.toJson()).toList();
    await prefs.setString('leadsList', jsonEncode(data));
  }

  Future<void> createLead() async {
    if (leadNameController.text.trim().isEmpty ||
        customerController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please fill required fields');
      return;
    }
    final revenue = double.tryParse(revenueController.text.trim());
    if (revenue == null || revenue <= 0) {
      Get.snackbar('Error', 'Please enter a valid revenue amount');
      return;
    }

    final newLead = LeadModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      leadName: leadNameController.text.trim(),
      customerName: customerController.text.trim(),
      expectedRevenue: revenue,
      email: emailController.text.trim(),
      phoneNumber: phoneController.text.trim(),
      description: descriptionController.text.trim(),
      stage: 'New',
      createdDate: DateTime.now(),
    );

    leadsList.add(newLead);
    await saveLeads();
    clearForm();
    Get.back();
    Get.snackbar('Success', 'Lead created successfully');
  }

  void clearForm() {
    leadNameController.clear();
    customerController.clear();
    revenueController.clear();
    emailController.clear();
    phoneController.clear();
    descriptionController.clear();
  }

  Future<void> updateStage(String id, String newStage) async {
    final index = leadsList.indexWhere((l) => l.id == id);
    if (index == -1) return;

    leadsList[index] = leadsList[index].copyWith(stage: newStage);
    await saveLeads();
  }

  Future<void> deleteLead(String id) async {
    leadsList.removeWhere((l) => l.id == id);
    await saveLeads();
  }

  Future<void> pickFilterDateFrom(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) filterDateFrom.value = picked;
  }

  Future<void> pickFilterDateTo(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) filterDateTo.value = picked;
  }

  void updateCustomerFilter(String value) {
    customerFilterQuery.value = value;
  }

  void selectStage(String stage) {
    selectedStage.value = stage;
  }

  List<LeadModel> get filteredLeads {
    var list = leadsList.toList();
    if (selectedStage.value != 'All Stages') {
      list = list.where((l) => l.stage == selectedStage.value).toList();
    }
    if (filterDateFrom.value != null) {
      list = list
          .where((l) => !l.createdDate.isBefore(filterDateFrom.value!))
          .toList();
    }
    if (filterDateTo.value != null) {
      list = list
          .where((l) => !l.createdDate.isAfter(filterDateTo.value!))
          .toList();
    }

    if (customerFilterQuery.value.trim().isNotEmpty) {
      final query = customerFilterQuery.value.trim().toLowerCase();
      list = list
          .where((l) => l.customerName.toLowerCase().contains(query))
          .toList();
    }
    return list;
  }

  Color getStageColor(String stage) {
    switch (stage) {
      case 'Won':
        return Colors.green;
      case 'New':
        return Colors.blue;
      case 'Qualified':
        return Colors.purple;
      case 'Sent Proposal':
        return Colors.amber;
      case 'Proposition':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  LeadModel? getLeadById(String id) {
    return leadsList.firstWhereOrNull((l) => l.id == id);
  }

  Future<void> addNote(String id) async {
    final controller = Get.find<AuthController>();
    if (noteController.text.trim().isEmpty) return;
    final index = leadsList.indexWhere((l) => l.id == id);
    if (index == -1) return;
    final newNote = LeadNoteModel(
      authorName: controller.currentUser.value?.name ?? 'Guest',
      note: noteController.text.trim(),
      date: DateTime.now(),
    );
    final updatedHistory = [...leadsList[index].history, newNote];
    leadsList[index] = leadsList[index].copyWith(history: updatedHistory);
    await saveLeads();
    noteController.clear();
  }

  void showDeleteDialog(String id) {
    Get.defaultDialog(
      title: "Delete Lead",
      middleText: "Are you sure you want to delete this lead?",
      textCancel: "Cancel",
      textConfirm: "Delete",
      onCancel: () => Get.back(),
      onConfirm: () async {
        await deleteLead(id);
        Get.back(); // dialog band karo
        Get.back(); // Details screen se list pe wapas
        Get.snackbar("Deleted", "Lead removed successfully");
      },
    );
  }

  void prefillEditForm(LeadModel lead) {
    leadNameController.text = lead.leadName;
    emailController.text = lead.email;
    phoneController.text = lead.phoneNumber;
    revenueController.text = lead.expectedRevenue.toString();
    descriptionController.text = lead.description;
    editStage.value = lead.stage;
  }

  Future<void> editLead(String id) async {
    final index = leadsList.indexWhere((lead) => lead.id == id);
    if (index == -1) return;
    final revenue = double.tryParse(revenueController.text.trim());
    if (revenue == null || revenue <= 0) {
      Get.snackbar('Error', 'Please enter a valid revenue amount');
      return;
    }

    final updatedLead = leadsList[index].copyWith(
      leadName: leadNameController.text.trim(),
      expectedRevenue: revenue,
      email: emailController.text.trim(),
      phoneNumber: phoneController.text.trim(),
      description: descriptionController.text.trim(),
      stage: editStage.value,
    );
    leadsList[index] = updatedLead;
    await saveLeads();
    clearForm();
    Get.back();
    Get.snackbar('Success', 'Lead updated successfully');
  }
}
