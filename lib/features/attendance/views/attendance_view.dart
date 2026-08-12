import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/attendance_action_tile.dart';
import 'package:hrm_app/components/custom_dropdown_field.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/attendance/controllers/attendace_controller.dart';
import 'package:intl/intl.dart';

class AttendanceView extends StatelessWidget {
  AttendanceView({super.key});
  final attendaceController = Get.put(AttendanceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacing.vertical30,
              CustomTitel(title: 'Attendace', ontap: () {}),
              AppSpacing.vertical30,
              Obx(
                () => Container(
                  padding: EdgeInsets.all(20.w),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.containerBackColor,
                    borderRadius: BorderRadius.circular(25.r),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: Row(
                    // spacing: 10.w,
                    children: [
                      Expanded(
                        child: CustomDropdownField(
                          hintText: 'Select Region',
                          value: attendaceController.selectedRegion.value?.name,
                          items: attendaceController.regions
                              .map((r) => r.name)
                              .toList(),
                          onChanged: (selectedName) {
                            final region = attendaceController.regions
                                .firstWhere((r) => r.name == selectedName);
                            attendaceController.setRegion(region);
                          },
                        ),
                      ),
                      AppSpacing.horizontal10,
                      Expanded(
                        child: CustomDropdownField(
                          hintText: 'Select SubRegion',
                          value:
                              attendaceController.selectedSubRegion.value?.name,
                          items: attendaceController.subRegions
                              .map((r) => r.name)
                              .toList(),
                          onChanged: (selectedName) {
                            if (selectedName == null) return;
                            final subRegion = attendaceController.subRegions
                                .firstWhere((r) => r.name == selectedName);
                            attendaceController.setSubRegion(subRegion);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppSpacing.vertical30,
              Obx(() {
                final data = attendaceController.currentAttendance.value;
                return Container(
                  padding: EdgeInsets.all(20.w),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.containerBackColor,
                    borderRadius: BorderRadius.circular(25.r),
                    border: Border.all(color: AppColors.primaryColor),
                  ),
                  child: (Column(
                    spacing: 20.h,
                    children: [
                      Text(
                        attendaceController.workingTime,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.textColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.timer,
                            width: 24.w,
                            height: 24.h,
                          ),
                          AppSpacing.horizontal10,
                          Text(
                            attendaceController.workingTime,
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AttendanceActionTile(
                              icon: 'assets/icon/time-add.png',
                              label: 'Check-in',
                              time: data.checkInTime != null
                                  ? DateFormat(
                                      'HH:mm',
                                    ).format(data.checkInTime!)
                                  : '--:--',
                            ),
                          ),
                          AppSpacing.horizontal15,
                          Expanded(
                            child: AttendanceActionTile(
                              icon: 'assets/icon/time-out.png',
                              label: 'Check-out',
                              time: data.checkOutTime != null
                                  ? DateFormat(
                                      'HH:mm',
                                    ).format(data.checkOutTime!)
                                  : '--:--',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AttendanceActionTile(
                              icon: 'assets/icon/break-in.png',
                              label: 'Break-in',
                              time: data.breakInTime != null
                                  ? DateFormat(
                                      'HH:mm',
                                    ).format(data.breakInTime!)
                                  : '--:--',
                            ),
                          ),
                          AppSpacing.horizontal15,
                          Expanded(
                            child: AttendanceActionTile(
                              icon: 'assets/icon/break-out.png',
                              label: 'Break-out',
                              time: data.breakOutTime != null
                                  ? DateFormat(
                                      'HH:mm',
                                    ).format(data.breakOutTime!)
                                  : '--:--',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 48.h,
                        width: double.infinity,
                        child: CustomButton(
                          title: data.status == 'In Progress'
                              ? 'Check Out'
                              : 'Check In',
                          onTap: () {
                            data.status == 'In Progress'
                                ? attendaceController.checkOut()
                                : attendaceController.checkIn();
                          },
                        ),
                      ),
                    ],
                  )),
                );
              }),
              AppSpacing.vertical30,
              Text(
                'My Attendance History',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              AppSpacing.vertical20,
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: attendaceController.attendancelist.length,
                  itemBuilder: (context, index) {
                    final history = attendaceController.attendancelist[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Container(
                        padding: EdgeInsets.all(15.w),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.containerBackColor,
                          borderRadius: BorderRadius.circular(25.r),
                          border: Border.all(color: AppColors.borderColor),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50.w,
                              height: 50.w,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    DateFormat('dd').format(history.date),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    DateFormat(
                                      'EEE',
                                    ).format(history.date).toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AppSpacing.horizontal30,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  DateFormat(
                                    'h:mm a',
                                  ).format(history.checkInTime),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'Check-in',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            AppSpacing.horizontal40,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  DateFormat(
                                    'h:mm a',
                                  ).format(history.checkOutTime),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                AppSpacing.vertical5,
                                Text(
                                  'Check-out',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            AppSpacing.horizontal40,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    history.totalHours,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  AppSpacing.vertical5,
                                  Text(
                                    'Total Hours',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
