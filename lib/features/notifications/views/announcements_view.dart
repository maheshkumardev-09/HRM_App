import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/notifications/controllers/announcement_controller.dart';
import 'package:hrm_app/routes/app_routes.dart';
import 'package:intl/intl.dart';

class AnnouncementsView extends StatelessWidget {
  AnnouncementsView({super.key});
  final controller = Get.find<AnnouncementController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.all(22.w),
        child: Column(
          children: [
            CustomTitel(title: 'Announcements'),
            AppSpacing.vertical30,
            Expanded(
              child: Obx(() {
                final item = controller.announcements;
                if (item.isEmpty) {
                  return Center(
                    child: Text(
                      'No announcements yet',
                      style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    final announce = item[index];
                    return Padding(
                      padding: EdgeInsetsGeometry.only(bottom: 10.h),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.announcementdetailview,
                            arguments: announce,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            border: BoxBorder.all(color: AppColors.borderColor),
                            color: AppColors.containerBackColor,
                          ),
                          width: double.infinity,
                          child: Row(
                            children: [
                              Image.asset(
                                AppImages.annunce,
                                width: 40.w,
                                height: 40.h,
                                fit: BoxFit.cover,
                              ),
                              AppSpacing.horizontal15,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    announce.title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  AppSpacing.vertical5,
                                  Text(
                                    DateFormat(
                                      'MMM dd',
                                    ).format(announce.dateTime),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
