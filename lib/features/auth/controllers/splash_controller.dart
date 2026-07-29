import 'package:get/get.dart';
import 'package:hrm_app/routes/app_routes.dart';
import 'package:hrm_app/services/storage_service.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  Future<void> checkLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    try {
      bool isLogin = await StorageService.isLoggedIn();

      if (isLogin) {
        Get.offAllNamed(AppRoutes.navbar);
      } else {
        Get.offAllNamed(AppRoutes.loginview);
      }
    } catch (e) {
      Get.offAllNamed(AppRoutes.loginview);
    }
  }
}
