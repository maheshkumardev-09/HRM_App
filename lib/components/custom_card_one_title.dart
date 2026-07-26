import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/constants/app_spacing.dart';

class CustomCardOneTitle extends StatelessWidget {
  final String title;
  final Widget widget;
  const CustomCardOneTitle({
    super.key,
    required this.title,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
        ),
        AppSpacing.vertical8,
        widget,
      ],
    );
  }
}
