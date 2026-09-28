import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/features/violations/data/violation_dummy_data.dart';
import 'package:hrm_app/features/violations/models/violation_model.dart';

class ViolationsController extends GetxController {
  RxList<ViolationModel> violationsList = <ViolationModel>[].obs;
  final RxString searchQuery = ''.obs;
  final searchController = TextEditingController();

  RxString selectedStatusFilter = 'All'.obs;
  List<String> statusFilterOptions = [
    'All',
    'Pending',
    'Approved',
    'Draft',
    'Rejected',
  ];

  @override
  void onInit() {
    super.onInit();
    loadViolations();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // ════════════════════════════════════════════════════════════════
  // LOAD DATA
  // ════════════════════════════════════════════════════════════════
  // Abhi dummy data se load ho raha hai. Kal jab backend/API ready ho,
  // SIRF is function ke andar ka code badalna hoga (http call laga dena) —
  // baaki poora app (UI, filtering, stat cards) bina chhede chalega.
  // Isi ko "separation of concerns" kehte hain — har cheez apni jagah,
  // ek cheez badlne se dusri cheez todni nahi padti.
  void loadViolations() {
    violationsList.value = ViolationDummyData.violations;
  }

  void updateSearch(String value) {
    searchQuery.value = value;
  }

  void selectStatusFilter(String status) {
    selectedStatusFilter.value = status;
  }

  // ════════════════════════════════════════════════════════════════
  // FILTERED LIST — search + status chip dono ek saath apply
  // ════════════════════════════════════════════════════════════════
  // Ye "get" (getter) hai, normal function nahi — matlab jab bhi UI
  // isko call karega, hamesha "abhi ke hisaab se latest" result milega,
  // bina manually kuch call kiye. Yaad karo RequestsController mein
  // filteredRequests bhi isi tarah bana tha.
  List<ViolationModel> get filteredViolations {
    var list = violationsList.toList();

    // Step 1: pehle status-chip filter lagao (agar "All" nahi hai)
    if (selectedStatusFilter.value != 'All') {
      list = list.where((v) => v.status == selectedStatusFilter.value).toList();
    }

    // Step 2: jo bacha usme se search bhi apply karo
    if (searchQuery.value.trim().isNotEmpty) {
      final query = searchQuery.value.trim().toLowerCase();
      list = list
          .where(
            (v) =>
                v.title.toLowerCase().contains(query) ||
                v.employeeName.toLowerCase().contains(query) ||
                v.category.toLowerCase().contains(query),
          )
          .toList();
    }

    return list;
  }

  // ════════════════════════════════════════════════════════════════
  // STAT CARD COUNTS — computed, NOT stored anywhere
  // ════════════════════════════════════════════════════════════════
  // Zaroori concept: ye 4 numbers ViolationModel ke fields NAHI hain.
  // Ye "violationsList" (poori list) ko count/filter karke nikale
  // gaye hain. Isliye agar list mein koi violation add/remove ho ya
  // uska status badle, ye counts apne aap sahi ho jayenge — kahin
  // manually update karne ki zaroorat nahi padegi.
  int get totalViolationsCount => violationsList.length;

  int get pendingCasesCount =>
      violationsList.where((v) => v.status == 'Pending').length;

  int get approvedCasesCount =>
      violationsList.where((v) => v.status == 'Approved').length;

  int get payrollDeductionsCount =>
      violationsList.where((v) => v.deductionAmount > 0).length;

  // ════════════════════════════════════════════════════════════════
  // DETAIL SCREEN HELPER
  // ════════════════════════════════════════════════════════════════
  // List se kisi card pe click hoga to us violation ka "id" pass karke
  // is function se poora ViolationModel object wapas milega, jo
  // detail screen ko dikhana hai.
  ViolationModel? getViolationById(String id) {
    return violationsList.firstWhereOrNull((v) => v.id == id);
  }

  // ════════════════════════════════════════════════════════════════
  // STATUS BADGE COLOR
  // ════════════════════════════════════════════════════════════════
  // Jaisa RequestsController mein getStatusColor() tha, wahi concept —
  // status string ke hisaab se badge ka color decide karta hai.
  Color getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      case 'Draft':
        return Colors.grey;
      case 'Pending':
      default:
        return Colors.orange;
    }
  }
}
