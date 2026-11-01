import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/features/documents/documents_dummy_data.dart';
import 'package:hrm_app/features/documents/documents_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentsController extends GetxController {
  RxList<DocumentsModel> documents = <DocumentsModel>[].obs;

  final searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  RxString groupedBy = 'Contact'.obs;
  List<String> groupByOptions = ['Contact', 'Date', 'Type'];

  RxString filteringFactor = 'My Documents'.obs;
  List<String> filteringOptions = ['My Documents', 'All Documents'];

  final RxSet<String> downloadedIds = <String>{}.obs;
  @override
  void onInit() {
    super.onInit();
    loadDocuments();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void loadDocuments() {
    documents.value = DocumentsDummyData.documents;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void selectGroupedBy(String value) {
    groupedBy.value = value;
  }

  void selectFilteringFactor(String value) {
    filteringFactor.value = value;
  }

  List<DocumentsModel> get filteredDocuments {
    if (searchQuery.value.trim().isEmpty) return documents;
    final query = searchQuery.value.trim().toLowerCase();
    return documents
        .where((d) => d.name.toLowerCase().contains(query))
        .toList();
  }

  Future<void> downloadDocument(String id, String url) async {
    if (downloadedIds.contains(id)) return;
    downloadedIds.add(id);

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('Error', 'Could not open the document link');
    }
  }
}
