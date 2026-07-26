import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custum_app_bar.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/routes/app_routes.dart';

class TimeOffView extends StatelessWidget {
  const TimeOffView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showMenu: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitel(title: 'My Leave Summary', ontap: () {}),
              AppSpacing.vertical30,
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.primaryColor),
                  color: Colors.grey.shade100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Remaning Leave Balances',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    AppSpacing.vertical20,
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.grey.shade200,
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            AppImages.timeofficon,
                            width: 50.w,
                            height: 50.h,
                            fit: BoxFit.contain,
                          ),
                          AppSpacing.horizontal10,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Paid Leave',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                AppSpacing.vertical8,
                                Text(
                                  '8 days remainnig',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppSpacing.vertical20,
                    SizedBox(
                      height: 40.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.teamcalendarview);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(12.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              color: AppColors.white,
                              size: 24.w,
                            ),
                            AppSpacing.horizontal10,
                            Text(
                              'Team Calendar',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.vertical30,
              Text(
                'My Leave',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.newleaverequestview),
        backgroundColor: AppColors.primaryColor,
        shape: const CircleBorder(),
        child: Icon(Icons.add, color: AppColors.white),
      ),
    );
  }
}
