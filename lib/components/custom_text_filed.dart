import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/constants/app_colors.dart';

class CustomTextFiled extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool hidepassword;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Color? fillColor;
  final bool showBorder;
  final Color? borderColor;
  final double borderRadius;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final VoidCallback? onTap;
  final int maxLines;
  const CustomTextFiled({
    super.key,
    required this.label,
    this.controller,
    this.hidepassword = false,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.fillColor,
    this.showBorder = true,
    this.borderColor,
    this.borderRadius = 12,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: hidepassword,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(fontSize: 14.sp),
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(fontSize: 16.sp, color: Colors.grey),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: fillColor ?? AppColors.whiteColor,
        suffixIconColor: Colors.grey,
        prefixIconColor: Colors.grey,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 14.h),
        constraints: BoxConstraints(minHeight: 56.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: showBorder
              ? BorderSide(color: borderColor ?? Colors.grey.shade300)
              : BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: showBorder
              ? BorderSide(color: borderColor ?? Colors.grey.shade300)
              : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: showBorder
              ? BorderSide(color: AppColors.primaryColor, width: 1.5)
              : BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
      ),
    );
  }
}
