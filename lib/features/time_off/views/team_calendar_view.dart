import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
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
          () => Column(
            children: [
              CustomTitel(title: 'Team Time Off Calendar', ontap: () {}),
              AppSpacing.vertical30,
              Card(
                child: TableCalendar(
                  firstDay: DateTime(2026),
                  lastDay: DateTime(2036),
                  focusedDay: controller.focusedDay.value,
                  selectedDayPredicate: (day) =>
                      isSameDay(controller.selectedDay.value, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    controller.onDaySelected(selectedDay, focusedDay);
                  },
                ),
              ),
              AppSpacing.vertical60,
              ListView.builder(itemBuilder: (context, index) {}),
            ],
          ),
        ),
      ),
    );
  }
}
