import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/constants/app_colors.dart';

class CustomTextFiled extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool hidepassword;
  final Widget? suffixIcon;
  final Widget? prefixicon;
  final bool readonly;
  final TextInputType? keyboardType;

  final ValueChanged<String>? onChanged;
  const CustomTextFiled({
    super.key,
    required this.label,
    required this.controller,
    this.hidepassword = false,
    this.suffixIcon,
    this.prefixicon,
    this.readonly = false,
    this.onChanged,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      obscureText: hidepassword,
      controller: controller,
      readOnly: readonly,
      onChanged: onChanged,
      decoration: InputDecoration(
        label: Text(label),
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey.shade100),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixicon,
      ),
    );
  }
}
