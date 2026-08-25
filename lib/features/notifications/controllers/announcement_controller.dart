import 'package:get/get.dart';
import 'package:hrm_app/features/notifications/data/announcement_dummy_data.dart';
import 'package:hrm_app/features/notifications/models/announcement_model.dart';

class AnnouncementController extends GetxController {
  final RxList<AnnouncementModel> announcements = <AnnouncementModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    final list = AnnouncementDummyData.announcements
        .map((e) => AnnouncementModel.fromJson(e))
        .toList();
    list.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    announcements.assignAll(list);
  }

  List<AnnouncementModel> get latestTwo {
    if (announcements.length <= 2) {
      return announcements;
    }
    return announcements.take(2).toList();
  }
}
