import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTitel extends StatelessWidget {
  final String title;
  final VoidCallback? ontap;

  const CustomTitel({super.key, required this.title, this.ontap});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
