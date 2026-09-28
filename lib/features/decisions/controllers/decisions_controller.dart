import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/features/decisions/data/decision_dummy_data.dart';
import 'package:hrm_app/features/decisions/models/decision_model.dart';

class DecisionsController extends GetxController {
  RxList<DecisionModel> decisionsList = <DecisionModel>[].obs;

  RxString selectedSort = 'Newest'.obs;
  List<String> sortOptions = ['Newest', 'Oldest'];

  RxString selectedFilter = 'All'.obs;
  List<String> filterOptions = ['All', 'Approved', 'Rejected', 'Pending'];

  @override
  void onInit() {
    super.onInit();
    loadDecisions();
  }

  void loadDecisions() {
    decisionsList.value = DecisionDummyData.decisions;
  }

  void selectSort(String sort) {
    selectedSort.value = sort;
  }

  void selectFilter(String filter) {
    selectedFilter.value = filter;
  }

  // ==================== FILTERED + SORTED LIST ====================

  List<DecisionModel> get filteredDecisions {
    var list = decisionsList.toList();
    if (selectedFilter.value != 'All') {
      list = list.where((d) => d.status == selectedFilter.value).toList();
    }
    if (selectedSort.value == 'Newest') {
      list.sort((a, b) => b.date.compareTo(a.date));
    } else {
      list.sort((a, b) => a.date.compareTo(b.date));
    }
    return list;
  }

  DecisionModel? getDecisionById(String id) {
    return decisionsList.firstWhereOrNull((d) => d.id == id);
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

  void resetAll() {
    selectedSort.value = 'Newest';
    selectedFilter.value = 'All';
  }
}
