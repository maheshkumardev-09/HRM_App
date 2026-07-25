import 'package:flutter/material.dart';
import 'package:hrm_app/constants/app_spacing.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
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
            children: [Text(title), AppSpacing.vertical8, widget],
          ),
        ),
        AppSpacing.horizontal20,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(title2), AppSpacing.vertical8, widget2],
          ),
        ),
      ],
    );
  }
}
