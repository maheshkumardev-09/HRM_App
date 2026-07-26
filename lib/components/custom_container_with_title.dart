import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/constants/app_spacing.dart';

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
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.grey.shade200,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titel,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
          AppSpacing.vertical10,
          widget,
        ],
      ),
    );
  }
}
