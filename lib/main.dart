import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/routes/binding/initial_binding.dart';
import 'package:hrm_app/routes/app_pages.dart';
import 'package:hrm_app/routes/app_routes.dart';
import 'package:hrm_app/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  bool isLogin = await StorageService.isLoggedIn();
  runApp(MyApp(isLogin: isLogin));
}

class MyApp extends StatelessWidget {
  final bool isLogin;
  const MyApp({super.key, required this.isLogin});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          scaffoldBackgroundColor: AppColors.whiteColor,
        ),
        debugShowCheckedModeBanner: false,
        initialBinding: InitialBinding(),
        initialRoute: isLogin ? AppRoutes.navbar : AppRoutes.loginview,
        getPages: AppPages.page,
      ),
    );
  }
}
