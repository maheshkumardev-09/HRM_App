import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Custom2 extends StatelessWidget {
  final String titel;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;
  const Custom2({
    super.key,
    required this.titel,
    required this.icon,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titel,
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
          ),
          GestureDetector(
            onTap: onTap,
            child: Icon(icon, color: color ?? Colors.black54),
          ),
        ],
      ),
    );
  }
}
