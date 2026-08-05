import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_action_card.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/attendance/controllers/attendace_controller.dart';
import 'package:hrm_app/features/auth/controllers/auth_controllr.dart';
import 'package:hrm_app/features/home/controllers/home_controller.dart';
import 'package:hrm_app/features/time_off/controllers/time_off_controller.dart';
import 'package:hrm_app/routes/app_routes.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final auth = Get.find<AuthControllr>();
  final home = Get.find<HomeController>();
  final attendaceController = Get.find<AttendanceController>();
  final timeOffController = Get.find<TimeOffController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(showMenu: true),
      drawer: Drawer(child: Column(children: [Text('okdfm')])),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(12.r),
                      child: Image.asset(
                        AppImages.profileImage,
                        width: 80.w,
                        height: 80.h,
                      ),
                    ),
                    AppSpacing.horizontal20,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome ${home.user.value?.name ?? "Gest"}',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          AppSpacing.vertical8,
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'view profile',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(onTap: () {}, child: Icon(Icons.more_vert)),
                  ],
                ),
                AppSpacing.vertical20,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.grey.shade200,
                  ),
                  padding: EdgeInsets.all(16.w),
                  width: double.infinity,
                  child: Column(
                    children: [
                      ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(12.r),
                          child: Image.asset(AppImages.dateicon),
                        ),
                        title: Text(
                          'Attandece Today',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        subtitle: Text(
                          attendaceController.currentAttendance.value.status,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      AppSpacing.vertical10,
                      SizedBox(
                        height: 40.h,
                        width: double.infinity,
                        child: CustomButton(
                          title:
                              attendaceController
                                      .currentAttendance
                                      .value
                                      .status ==
                                  'In Progress'
                              ? 'Check Out'
                              : 'Check In',

                          onTap: () {
                            if (attendaceController
                                    .currentAttendance
                                    .value
                                    .status ==
                                'In Progress') {
                              attendaceController.checkOut();
                            } else {
                              attendaceController.checkIn();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpacing.vertical20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Remaning Balances',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      child: Text('ViewAll', style: TextStyle(fontSize: 14.sp)),
                    ),
                  ],
                ),
                AppSpacing.vertical20,
                Row(
                  children: timeOffController.balanceList.take(2).map((leave) {
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: Colors.grey.shade200,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 16.h,
                            horizontal: 8.w,
                          ),
                          child: Column(
                            children: [
                              Text(
                                leave.leaveType,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                '${leave.useDday}/${leave.totalDay} Days',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                AppSpacing.vertical20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Quick Actions',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.actions),
                      child: Text('ViewAll', style: TextStyle(fontSize: 14.sp)),
                    ),
                  ],
                ),
                AppSpacing.vertical20,
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  mainAxisSpacing: 12.h,
                  crossAxisSpacing: 12.w,
                  children: home.quickActions.take(6).map((action) {
                    return CustomActionCard(action: action);
                  }).toList(),
                ),
                AppSpacing.vertical20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Announcements',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      child: Text('ViewAll', style: TextStyle(fontSize: 14.sp)),
                    ),
                  ],
                ),
                AppSpacing.vertical20,
                Column(
                  children: home.announcement.take(2).map((announce) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: Colors.grey.shade200,
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.0.h,
                            horizontal: 8.w,
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                AppImages.annunce,
                                width: 40.w,
                                height: 40.h,
                              ),
                              SizedBox(width: 10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    announce.title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    announce.date.day.toString(),
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
