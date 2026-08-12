import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/constants/app_spacing.dart';

class CustomRowCard extends StatelessWidget {
  const CustomRowCard({
    super.key,
    required this.title,
    required this.title2,
    required this.widget,
    required this.widget2,
  });
  final String title;
  final String title2;
  final Widget widget;
  final Widget widget2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              AppSpacing.vertical10,
              widget,
            ],
          ),
        ),
        AppSpacing.horizontal20,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title2,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              AppSpacing.vertical10,
              widget2,
            ],
          ),
        ),
      ],
    );
  }
}
