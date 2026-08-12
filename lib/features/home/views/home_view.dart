import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_action_card.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_section_header.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/attendance/controllers/attendace_controller.dart';
import 'package:hrm_app/features/auth/controllers/auth_controller.dart';
import 'package:hrm_app/features/home/controllers/home_controller.dart';
import 'package:hrm_app/features/time_off/controllers/time_off_controller.dart';
import 'package:hrm_app/routes/app_routes.dart';
import 'package:intl/intl.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final auth = Get.find<AuthController>();
  final home = Get.find<HomeController>();
  final attendaceController = Get.find<AttendanceController>();
  final timeOffController = Get.find<TimeOffController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(showBackButton: false),
      drawer: Drawer(child: Column(children: [Text('okdfm')])),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(25.r),
                      child: Image.asset(
                        AppImages.profileImage,
                        width: 80.w,
                        height: 80.h,
                      ),
                    ),
                    AppSpacing.horizontal15,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome ${home.user.value?.name ?? "Gest"}',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          AppSpacing.vertical10,
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'View Profile',
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
                AppSpacing.vertical30,
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    color: AppColors.containerBackColor,
                    border: Border.all(color: AppColors.primaryColor),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            child: Image.asset(
                              AppImages.dateicon,
                              width: 50.w,
                              height: 50.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                          AppSpacing.horizontal10,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Attandece Today',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              AppSpacing.vertical5,
                              Text(
                                attendaceController
                                    .currentAttendance
                                    .value
                                    .status,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      AppSpacing.vertical20,
                      SizedBox(
                        height: 48.h,
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
                AppSpacing.vertical30,
                CustomSectionHeader(
                  title: 'My Remaning Balances',
                  onViewAllTap: () {
                    Get.toNamed(AppRoutes.timeoffview);
                  },
                ),
                AppSpacing.vertical20,
                Row(
                  spacing: 10.w,
                  children: timeOffController.balanceList.take(2).map((leave) {
                    return Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                          color: AppColors.whiteColor,
                          border: Border.all(color: AppColors.borderColor),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 15.h,
                        ),
                        child: Column(
                          children: [
                            Text(
                              leave.leaveType,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            AppSpacing.vertical5,
                            Text(
                              '${leave.useDday}/${leave.totalDay} Days',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w300,
                                color: AppColors.textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                AppSpacing.vertical30,
                CustomSectionHeader(
                  title: 'Quick Actions',
                  onViewAllTap: () {
                    Get.toNamed(AppRoutes.actions);
                  },
                ),
                AppSpacing.vertical20,
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: home.quickActions.take(6).length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10.h,
                    crossAxisSpacing: 10.w,
                    mainAxisExtent: 105.h,
                  ),
                  itemBuilder: (context, index) {
                    final action = home.quickActions[index];
                    return CustomActionCard(action: action);
                  },
                ),
                AppSpacing.vertical30,
                CustomSectionHeader(title: 'Announcements'),
                AppSpacing.vertical20,
                Column(
                  spacing: 10.h,
                  children: home.announcements.take(2).map((announce) {
                    return Container(
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
                              ),
                              AppSpacing.vertical5,
                              Text(
                                DateFormat('MMM dd').format(announce.date),
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
