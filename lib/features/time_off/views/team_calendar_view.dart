import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custum_app_bar.dart';
import 'package:hrm_app/constants/app_spacing.dart';

class TeamCalendarView extends StatelessWidget {
  const TeamCalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showMenu: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Column(
          children: [
            CustomTitel(title: 'Team Time Off Calendar', ontap: () {}),
            AppSpacing.vertical30,
          ],
        ),
      ),
    );
  }
}
