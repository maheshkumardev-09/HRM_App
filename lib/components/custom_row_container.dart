import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/constants/app_colors.dart';

class CustomRowContainer extends StatelessWidget {
  final String title;
  final IconData icon;
  final String title2;
  final IconData icon2;
  final VoidCallback? onTap1;
  final VoidCallback? onTap2;

  const CustomRowContainer({
    super.key,
    required this.title,
    required this.icon,
    required this.title2,
    required this.icon2,
    required this.onTap1,
    required this.onTap2,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyle(fontSize: 14.sp)),
                GestureDetector(
                  onTap: onTap2,
                  child: Icon(icon, size: 20.w),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title2, style: TextStyle(fontSize: 14.sp)),
                GestureDetector(
                  onTap: onTap1,
                  child: Icon(icon2, size: 20.w),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
