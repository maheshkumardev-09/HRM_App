import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_card_one_title.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/constants/app_spacing.dart';

class NewTimesheetView extends StatelessWidget {
  const NewTimesheetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showMenu: false),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 10.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTitel(title: 'Create Nw Timesheet', ontap: () {}),
              AppSpacing.vertical30,
              CustomCardOneTitle(
                title: 'Date*',
                widget: CustomTextFiled(
                  label: 'dd/mm/yyyy',
                  controller: TextEditingController(),
                  suffixIcon: Icon(Icons.calendar_today_outlined),
                ),
              ),
              AppSpacing.vertical20,
              CustomCardOneTitle(title: 'Project', widget: Text('')),
            ],
          ),
        ),
      ),
    );
  }
}
