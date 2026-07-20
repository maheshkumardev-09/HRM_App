import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/data/models/quick_action_model.dart';

class CustomActionCard extends StatelessWidget {
  const CustomActionCard({super.key, required this.action});
  final QuickActionModel action;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(action.route);
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(action.icon, width: 40.w, height: 40.h),
            AppSpacing.vertical8,
            Text(
              action.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.sp),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
