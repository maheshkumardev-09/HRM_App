import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_spacing.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.containerBackColor,
        elevation: 1,
        title: Row(
          children: [
            Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.containerBackColordark,
              ),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  AppImages.backIcon,
                  width: 22.w,
                  height: 22.h,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            AppSpacing.horizontal20,
            Text(
              'Notifications',
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(22.w),
        child: Column(children: []),
      ),
    );
  }
}
