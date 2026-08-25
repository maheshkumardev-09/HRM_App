import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/time_off/controllers/time_off_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class TeamCalendarView extends StatelessWidget {
  TeamCalendarView({super.key});
  final controller = Get.find<TimeOffController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                CustomTitel(title: 'Team Time Off Calendar'),
                AppSpacing.vertical30,
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: AppColors.containerBackColor,
                    borderRadius: BorderRadius.circular(25.r),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: TableCalendar(
                    firstDay: DateTime.now(),
                    lastDay: DateTime(2036),
                    focusedDay: controller.focusedDay.value,
                    selectedDayPredicate: (day) =>
                        isSameDay(controller.selectedDay.value, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      controller.onDaySelected(selectedDay, focusedDay);
                    },
                    rowHeight: 50.h,
                    daysOfWeekHeight: 45.h,
                    headerStyle: HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                      leftChevronIcon: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 9.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: AppColors.whiteColor,
                        ),
                        child: Icon(Icons.chevron_left, size: 22.w),
                      ),
                      rightChevronIcon: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 9.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: AppColors.whiteColor,
                        ),
                        child: Icon(Icons.chevron_right, size: 22.w),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.containerBackColordark,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      headerMargin: EdgeInsets.zero,
                      headerPadding: EdgeInsets.zero,
                      titleTextStyle: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
                      ),
                      weekendStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(color: Colors.grey),
                      selectedDecoration: BoxDecoration(
                        color: AppColors.primaryColor,
                      ),
                      cellMargin: EdgeInsets.all(11.w),
                      outsideDaysVisible: true,
                    ),
                  ),
                ),
                AppSpacing.vertical30,
                if (controller.isDaySelected.value)
                  if (controller.selectedDAyleaves.isEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              'No leaves on this day',
                              style: TextStyle(color: Colors.grey),
                            ),
                            AppSpacing.vertical10,
                            SizedBox(
                              height: 48.h,
                              width: 200.w,
                              child: CustomButton(
                                title: 'show List',
                                onTap: () {
                                  controller.isDaySelected.value = false;
                                  controller.selectedDay.value = null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.selectedDAyleaves.length,
                      itemBuilder: (context, index) {
                        final teamLeave = controller.selectedDAyleaves[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: AppColors.containerBackColordark,
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/icon/icon22.png",
                                  height: 45.h,
                                  width: 45.w,
                                ),
                                AppSpacing.horizontal10,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        teamLeave.employeeName,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      AppSpacing.vertical10,
                                      Text(
                                        '${teamLeave.startTime}-${teamLeave.endTime}',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.w),
                                    color: AppColors.primaryColor,
                                  ),
                                  child: Row(
                                    spacing: 5.w,
                                    children: [
                                      Icon(
                                        Icons.av_timer,
                                        size: 22.w,
                                        color: AppColors.whiteColor,
                                      ),
                                      Text(
                                        teamLeave.leaveType,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColors.whiteColor,
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
                    )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.teamLeaveList.length,
                    itemBuilder: (context, index) {
                      final teamLeave = controller.teamLeaveList[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: AppColors.containerBackColordark,
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icon/icon22.png",
                                height: 45.h,
                                width: 45.w,
                              ),
                              AppSpacing.horizontal10,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      teamLeave.employeeName,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    AppSpacing.vertical10,
                                    Text(
                                      '${teamLeave.startTime}-${teamLeave.endTime}',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.w),
                                  color: AppColors.primaryColor,
                                ),
                                child: Row(
                                  spacing: 5.w,
                                  children: [
                                    Icon(
                                      Icons.av_timer,
                                      size: 22.w,
                                      color: AppColors.whiteColor,
                                    ),
                                    Text(
                                      teamLeave.leaveType,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColors.whiteColor,
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
      ),
    );
  }
}
