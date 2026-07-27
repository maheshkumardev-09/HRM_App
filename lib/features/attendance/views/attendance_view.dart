import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/attendance_action_tile.dart';
import 'package:hrm_app/components/custom_row_container.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/attendance/controllers/attendace_controller.dart';
import 'package:intl/intl.dart';

class AttendanceView extends StatelessWidget {
  AttendanceView({super.key});
  final attendaceController = Get.put(AttendanceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showMenu: false),
      body: Padding(
        padding: EdgeInsets.all(10.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTitel(title: 'Attendace', ontap: () {}),
              AppSpacing.vertical20,
              Container(
                padding: EdgeInsets.all(8.0.w),
                height: 90.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: CustomRowContainer(
                  onTap1: () {},
                  title: 'Select Region',
                  icon: Icons.keyboard_arrow_down,
                  title2: 'Select Sub-region',
                  icon2: Icons.keyboard_arrow_down,
                  onTap2: () {},
                ),
              ),
              AppSpacing.vertical20,
              Obx(() {
                final data = attendaceController.currentAttendance.value;
                return Container(
                  padding: EdgeInsets.all(20.w),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: (Column(
                    children: [
                      Text(
                        '2 Hours 12 minutes since check-in',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      AppSpacing.vertical20,
                      Text(
                        '12:12:00 PM',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppSpacing.vertical20,
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
                          AppSpacing.horizontal10,
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
                      AppSpacing.vertical10,
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
                          AppSpacing.horizontal10,
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
                      AppSpacing.vertical20,
                      SizedBox(
                        height: 50.h,
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
              AppSpacing.vertical20,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'My Attendance History',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              AppSpacing.vertical20,
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: attendaceController.attendanceHistory.length,
                itemBuilder: (context, index) {
                  final history = attendaceController.attendanceHistory[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48.w,
                            height: 48.w,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(12.r),
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
                          AppSpacing.horizontal12,
                          Expanded(
                            child: Column(
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
                          ),
                          Expanded(
                            child: Column(
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
                                AppSpacing.vertical2,
                                Text(
                                  'Check-out',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  history.totalHours,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 2.h),
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
            ],
          ),
        ),
      ),
    );
  }
}
