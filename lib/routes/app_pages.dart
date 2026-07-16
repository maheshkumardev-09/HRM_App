import 'package:get/get.dart';
import 'package:hrm_app/features/auth/views/log_in_view.dart';
import 'package:hrm_app/features/auth/views/splash_view.dart';

class AppPages {
  static final page = [
    GetPage(name: '/splashview', page: () => SplashView()),
    GetPage(name: '/loginview', page: () => LogInView()),
  ];
}
