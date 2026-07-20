import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/components/custom.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custum_app_bar.dart';
import 'package:hrm_app/constants/app_spacing.dart';

class ExpensesView extends StatelessWidget {
  const ExpensesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showMenu: false),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            CustomTitel(title: 'My Expenses'),
            AppSpacing.vertical20,
            Container(
              padding: EdgeInsets.all(8.w),
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Custom(
                title: 'Date From',
                icon: Icons.calendar_today_outlined,
                title2: 'Date To',
                icon2: Icons.calendar_today_outlined,
              ),
            ),
            AppSpacing.vertical20,
          ],
        ),
      ),
    );
  }
}
