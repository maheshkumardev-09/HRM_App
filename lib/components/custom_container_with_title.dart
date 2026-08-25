import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/constants/app_colors.dart';

class CustomContainerWithTitle extends StatelessWidget {
  final String titel;
  final Widget widget;
  const CustomContainerWithTitle({
    super.key,
    required this.titel,
    required this.widget,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        color: AppColors.containerBackColor,
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        spacing: 15.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titel,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
          widget,
        ],
      ),
    );
  }
}
