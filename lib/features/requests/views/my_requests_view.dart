import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_row_container.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/routes/app_routes.dart';

class MyRequestsView extends StatelessWidget {
  const MyRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Column(
          children: [
            CustomTitel(title: 'My Requests'),
            AppSpacing.vertical30,
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 8.w),
              decoration: BoxDecoration(
                color: AppColors.gary200Color,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: CustomRowContainer(
                title: 'Date from',
                icon: Icons.calendar_today_outlined,
                title2: 'Date to',
                icon2: Icons.calendar_today_outlined,
                onTap1: () {},
                onTap2: () {},
              ),
            ),
            AppSpacing.vertical30,
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.requestdetailsview),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: AppColors.gary200Color,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: AppColors.primaryColor,
                                  ),
                                  child: Icon(
                                    Icons.receipt_long_outlined,
                                    color: AppColors.whiteColor,
                                    size: 25.w,
                                  ),
                                ),
                                AppSpacing.horizontal10,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Type',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Descreption',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 8.h,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColors.primaryColor,
                                  ),
                                  child: Text('Edit'),
                                ),
                              ],
                            ),
                            AppSpacing.vertical10,
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Staet Date'),
                                    Text('20-06-2026'),
                                  ],
                                ),
                                AppSpacing.horizontal40,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('End Date'),
                                      Text('20-06-2026'),
                                    ],
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
