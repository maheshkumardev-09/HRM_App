import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/constants/app_colors.dart';

class CustomTextFiled extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool hidepassword;
  final Widget? suffixIcon;

  const CustomTextFiled({
    super.key,
    required this.label,
    required this.controller,
    this.hidepassword = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: hidepassword,
      controller: controller,
      decoration: InputDecoration(
        label: Text(label),
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
