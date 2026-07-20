import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/routes/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.navbar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
