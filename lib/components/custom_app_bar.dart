import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.showMenu = false});
  final bool showMenu;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: showMenu
          ? IconButton(
              icon: const Icon(Icons.menu, color: AppColors.primaryColor),
              onPressed: () {},
            )
          : IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
              onPressed: Get.back,
            ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.notifications_outlined,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(width: 20.w),
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.calendar_today_outlined,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(width: 30.w),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
