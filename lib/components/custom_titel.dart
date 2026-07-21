import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTitel extends StatelessWidget {
  final String title;
  final VoidCallback ontap;

  const CustomTitel({super.key, required this.title, required this.ontap});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
        ),
        GestureDetector(onTap: ontap, child: Icon(Icons.more_vert)),
      ],
    );
  }
}
