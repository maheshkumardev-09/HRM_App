import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/features/auth/controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  final controller = Get.put(SplashController());

  SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Image.asset(
          AppImages.logo,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
