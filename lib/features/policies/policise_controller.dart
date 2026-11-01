import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/features/policies/policies_model.dart';
import 'package:hrm_app/features/policies/policise_dummy_data.dart';
import 'package:url_launcher/url_launcher.dart';

class PoliciesController extends GetxController {
  RxList<PoliciesModel> policies = <PoliciesModel>[].obs;
  final RxSet<String> pdfDownloaded = <String>{}.obs;
  final searchController = TextEditingController();
  final searchQuery = ''.obs;
  @override
  void onInit() {
    loadPolicies();
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void loadPolicies() {
    policies.value = PoliciesDummyData.policies;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  List<PoliciesModel> get filteredPolicies {
    if (searchQuery.value.isEmpty) return policies;
    final query = searchQuery.value.toLowerCase();
    return policies
        .where((policy) => policy.title.toLowerCase().contains(query))
        .toList();
  }

  Future<void> downloadPdf(String pdfUrl) async {
    if (pdfDownloaded.contains(pdfUrl)) {
      return;
    }
    pdfDownloaded.add(pdfUrl);
    final url = Uri.parse(pdfUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      Get.snackbar('Error', 'Could not open PDF URL');
    }
  }
}
