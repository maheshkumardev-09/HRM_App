import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_image.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onCalendarTap;
  final VoidCallback? onNotificationTap;
  // final bool hasNotification;
  final bool showBackButton;
  final bool showActions;
  final Color backgroundColor;
  const CustomAppBar({
    super.key,
    this.showBackButton = true,
    this.onMenuTap,
    this.onCalendarTap,
    this.onNotificationTap,
    // required this.hasNotification,
    this.showActions = true,
    this.backgroundColor = AppColors.whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            showBackButton
                ? Container(
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
                  )
                : Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColors.containerBackColordark,
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        AppImages.menuIcon,
                        width: 22.w,
                        height: 22.h,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
            Row(
              children: [
                Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.containerBackColordark,
                  ),
                  child: GestureDetector(
                    onTap: onCalendarTap,
                    child: Image.asset(
                      AppImages.calendarIcon,
                      width: 22.w,
                      height: 22.h,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.containerBackColordark,
                  ),
                  child: GestureDetector(
                    onTap: onNotificationTap,
                    child: Image.asset(
                      AppImages.notificationIcon,
                      width: 22.w,
                      height: 22.h,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
