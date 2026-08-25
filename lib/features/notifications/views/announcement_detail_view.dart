import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/notifications/controllers/announcement_controller.dart';
import 'package:hrm_app/features/notifications/models/announcement_model.dart';
import 'package:intl/intl.dart';

class AnnouncementDetailView extends StatelessWidget {
  AnnouncementDetailView({super.key});
  final announcementControler = Get.find<AnnouncementController>();

  @override
  Widget build(BuildContext context) {
    final AnnouncementModel announce = Get.arguments as AnnouncementModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.containerBackColor,
        elevation: 0,
        automaticallyImplyLeading: false,
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    announce.title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    announce.sentBy,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  DateFormat('dd/MMM/yyyy').format(announce.dateTime),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  DateFormat('hh:mm a').format(announce.dateTime),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.containerBackColor,
                borderRadius: BorderRadius.circular(25.r),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: Text(announce.message),
            ),
          ],
        ),
      ),
    );
  }
}
