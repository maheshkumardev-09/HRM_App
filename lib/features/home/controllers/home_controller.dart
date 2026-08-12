import 'dart:convert';

import 'package:get/get.dart';
import 'package:hrm_app/features/home/models/announcement_model.dart';
import 'package:hrm_app/features/auth/models/user_moel.dart';
import 'package:hrm_app/features/home/data/home_dummy_data.dart';
import 'package:hrm_app/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  Rx<UserMoel?> user = Rx<UserMoel?>(null);
  final quickActions = HomeDummyData.items;
  RxList<AnnouncementModel> announcements = <AnnouncementModel>[].obs;
  @override
  void onInit() {
    loadUser();
    loadAnnouncemenat();
    super.onInit();
  }

  Future<void> loadUser() async {
    user.value = await StorageService.getUser();
  }

  Future<void> loadAnnouncemenat() async {
    final pres = await SharedPreferences.getInstance();
    final data = pres.getString('announcements');
    if (data == null) {
      announcements.value = HomeDummyData.announcements
          .map((e) => AnnouncementModel.fromJson(e))
          .toList();
    } else {
      List list = jsonDecode(data);

      announcements.value = list
          .map((e) => AnnouncementModel.fromJson(e))
          .toList();
    }
  }

  Future<void> saveAnnouncemenat() async {
    final pres = await SharedPreferences.getInstance();
    final data = announcements.map((e) => e.toJson()).toList();
    await pres.setString('announcements', jsonEncode(data));
  }
}
