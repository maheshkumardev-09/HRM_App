import 'package:get/get.dart';
import 'package:hrm_app/features/home/models/announcement_model.dart';
import 'package:hrm_app/features/auth/models/user_moel.dart';
import 'package:hrm_app/features/home/data/quick_actions_data.dart';
import 'package:hrm_app/services/storage_service.dart';

class HomeController extends GetxController {
  Rx<UserMoel?> user = Rx<UserMoel?>(null);
  final quickActions = QuickActionsData.items;
  @override
  void onInit() {
    loadUser();
    super.onInit();
  }

  Future<void> loadUser() async {
    user.value = await StorageService.getUser();
  }

  var announcement = <AnnouncementModel>[
    AnnouncementModel(
      id: '1',
      title: 'Office Closure',
      date: DateTime(2025, 3, 21),
    ),
    AnnouncementModel(
      id: '2',
      title: 'Annual Review Deadline',
      date: DateTime(2025, 3, 21),
    ),
  ].obs;
}
