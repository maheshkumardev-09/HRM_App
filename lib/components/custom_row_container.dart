import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/constants/app_spacing.dart';

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
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.w),
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyle(fontSize: 12.sp)),
                GestureDetector(onTap: onTap2, child: Icon(icon)),
              ],
            ),
          ),
        ),
        AppSpacing.horizontal8,
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.w),
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title2, style: TextStyle(fontSize: 12.sp)),
                GestureDetector(onTap: onTap1, child: Icon(icon2)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
