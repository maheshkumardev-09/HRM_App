import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/constants/app_colors.dart';

class CustomDropdownField extends StatelessWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? hintText;

  const CustomDropdownField({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        icon: Icon(Icons.keyboard_arrow_down, size: 22, color: Colors.grey),
        initialValue: items.contains(value) ? value : null,
        decoration: InputDecoration(
          hint: Text(
            hintText ?? '',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 16.h,
          ),

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: AppColors.borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: AppColors.borderColor),
          ),
        ),
        items: items.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e, style: TextStyle(fontSize: 15.sp)),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
