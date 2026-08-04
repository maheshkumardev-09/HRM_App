import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
      appBar: CustomAppBar(showMenu: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                CustomTitel(title: 'Team Time Off Calendar', ontap: () {}),
                AppSpacing.vertical30,
                Container(
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: TableCalendar(
                    firstDay: DateTime(2026),
                    lastDay: DateTime(2036),
                    focusedDay: controller.focusedDay.value,
                    selectedDayPredicate: (day) =>
                        isSameDay(controller.selectedDay.value, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      controller.onDaySelected(selectedDay, focusedDay);
                    },

                    headerStyle: HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                      leftChevronIcon: Icon(Icons.chevron_left),
                      rightChevronIcon: Icon(Icons.chevron_right),
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
                      todayDecoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      outsideDaysVisible: true,
                    ),
                  ),
                ),
                AppSpacing.vertical60,
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.teamLeaveList.length,
                  itemBuilder: (context, index) {
                    final teamLeave = controller.teamLeaveList[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Container(
                        padding: EdgeInsets.all(15.w),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Image.asset(teamLeave.employeeImage),
                            AppSpacing.horizontal10,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(teamLeave.employeeName),
                                Text(
                                  '${teamLeave.startTime}-${teamLeave.endTime}',
                                ),
                              ],
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
