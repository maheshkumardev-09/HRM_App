import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/time_off/controllers/time_off_controller.dart';
import 'package:hrm_app/routes/app_routes.dart';
import 'package:intl/intl.dart';

class TimeOffView extends StatelessWidget {
  TimeOffView({super.key});
  final timeoffcontroller = Get.find<TimeOffController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Obx(() {
        if (timeoffcontroller.leaveList.isEmpty) {
          return Center(
            child: Column(
              children: [
                Text("No Leave Request"),
                AppSpacing.vertical10,
                CustomButton(
                  title: 'Add Leave',
                  onTap: () => Get.toNamed(AppRoutes.newleaverequestview),
                ),
              ],
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTitel(title: 'My Leave Summary'),
                AppSpacing.vertical30,
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    border: Border.all(color: AppColors.primaryColor),
                    color: AppColors.containerBackColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Remaining Leave Balances',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      AppSpacing.vertical20,
                      Container(
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                          color: AppColors.containerBackColordark,
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              AppImages.timeofficon,
                              width: 50.w,
                              height: 50.h,
                              fit: BoxFit.contain,
                            ),
                            AppSpacing.horizontal15,
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
                                  AppSpacing.vertical10,
                                  timeoffcontroller.balanceList.isNotEmpty
                                      ? Text(
                                          '${timeoffcontroller.balanceList.first.remaining} days remainnig',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : Text(
                                          '-- days remaining',
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
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.teamcalendarview);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(15.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                color: AppColors.whiteColor,
                                size: 24.w,
                              ),
                              AppSpacing.horizontal10,
                              Text(
                                'Team Calendar',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.whiteColor,
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
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AppSpacing.vertical20,
                ListView.builder(
                  itemCount: timeoffcontroller.leaveList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data = timeoffcontroller.leaveList[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: GestureDetector(
                        onLongPress: () =>
                            timeoffcontroller.showDeleteDialog(data),
                        child: Container(
                          padding: EdgeInsets.all(15.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColors.containerBackColor,
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 50.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.r),
                                      color: AppColors.primaryColor,
                                    ),
                                    child: Image.asset(
                                      'assets/icon/leave.png',
                                      height: 24.h,
                                      width: 24.w,
                                    ),
                                  ),
                                  AppSpacing.horizontal15,
                                  Expanded(
                                    child: Text(
                                      data.allocation,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 5.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.r),
                                      color: timeoffcontroller.getStatusColor(
                                        data.status,
                                      ),
                                    ),
                                    child: Text(
                                      data.status,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              AppSpacing.vertical10,
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        DateFormat(
                                          'yyy-MM-dd',
                                        ).format(data.dateFrom),
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'Date From',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                  AppSpacing.horizontal20,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          DateFormat(
                                            'yyy-MM-dd',
                                          ).format(data.dateTo),
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          'Date To',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${data.leaveDuration.toString()} Days',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 5.h,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(50.r),
                                    ),
                                    child: Text(
                                      'Used',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColors.primaryColor,
                                      ),
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
              ],
            ),
          ),
        );
      }),
      floatingActionButton: SizedBox(
        height: 60.h,
        width: 60.w,
        child: FloatingActionButton(
          onPressed: () => Get.toNamed(AppRoutes.newleaverequestview),
          backgroundColor: AppColors.primaryColor,
          shape: const CircleBorder(),
          child: Icon(Icons.add, color: AppColors.whiteColor),
        ),
      ),
    );
  }
}
