// section_header.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/constants/app_colors.dart';

class CustomSectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAllTap;
  final String viewAllText;
  final bool showViewAll;

  const CustomSectionHeader({
    super.key,
    required this.title,
    this.onViewAllTap,
    this.viewAllText = 'View All',
    this.showViewAll = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        if (showViewAll)
          GestureDetector(
            onTap: onViewAllTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  viewAllText,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(width: 5.w), // chhota gap
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12.sp,
                  color: AppColors.textColor,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
