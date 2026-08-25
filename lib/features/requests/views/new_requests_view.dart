import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_titel.dart';

class NewRequestsView extends StatelessWidget {
  const NewRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Column(children: [CustomTitel(title: 'New requests')]),
      ),
    );
  }
}
