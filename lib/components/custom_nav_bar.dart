import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/features/dashboard/bottom_nav_controller.dart';
import 'package:hrm_app/features/dashboard/model/nav_item_model.dart';

class CustomNavBar extends StatelessWidget {
  CustomNavBar({super.key});
  final bottomNavController = Get.find<BottomNavController>();

  final List<NavItemModel> navicons = [
    NavItemModel(
      selectedIcon: 'assets/icon/home.png',
      unselectedIcon: 'assets/icon/home1.png',
    ),
    NavItemModel(
      selectedIcon: 'assets/icon/users.png',
      unselectedIcon: 'assets/icon/users1.png',
    ),
    NavItemModel(
      selectedIcon: 'assets/icon/notes-check.png',
      unselectedIcon: 'assets/icon/notes-check1.png',
    ),
    NavItemModel(
      selectedIcon: 'assets/icon/bill.png',
      unselectedIcon: 'assets/icon/bill1.png',
    ),
    NavItemModel(
      selectedIcon: 'assets/icon/barchart.png',
      unselectedIcon: 'assets/icon/barchart1.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: double.infinity,
        height: 77.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF000000).withValues(alpha: 0.1),
              blurRadius: 15,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(navicons.length, (index) {
            final isSelectedItem =
                bottomNavController.currentIndex.value == index;
            final item = navicons[index];
            return Expanded(
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 5.w),
                child: GestureDetector(
                  onTap: () {
                    bottomNavController.currentIndex(index);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        isSelectedItem
                            ? item.unselectedIcon
                            : item.selectedIcon,
                        color: AppColors.primaryColor,
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(height: 8.h),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: isSelectedItem ? 20.w : 0,
                        height: 2.h,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
