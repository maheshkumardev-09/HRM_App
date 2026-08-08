import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';

class AttendanceActionTile extends StatelessWidget {
  const AttendanceActionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.time,
  });

  final String icon;
  final String label;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.containerBackColordark,
        borderRadius: BorderRadius.circular(25.r),
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
            child: Image.asset(icon, width: 24.w, height: 24.h),
          ),
          AppSpacing.horizontal10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12.sp, color: AppColors.textColor),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
