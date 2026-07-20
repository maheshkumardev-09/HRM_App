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
  final String label; // "Check-in", "Check-out", "Break-in", "Break-out"
  final String time; // "16:27" ya "--:--" agar abhi hua nahi

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          // 🔹 Icon Box (purple background)
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Image.asset(icon, width: 24.w, height: 24.h),
          ),
          AppSpacing.horizontal10,

          // 🔹 Label + Time
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 14.sp,
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
