import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/constants/app_colors.dart';

class CustomRequestTitel extends StatelessWidget {
  final String subTitle;
  const CustomRequestTitel({super.key, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15.h,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'New Request',
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 7.w,
          children: [
            Icon(
              Icons.check_circle,
              size: 14.sp,
              color: AppColors.primaryColor,
            ),
            Text(
              subTitle,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    );
  }
}
