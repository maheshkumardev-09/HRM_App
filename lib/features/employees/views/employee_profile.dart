import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custum_app_bar.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/employees/controllers/employees_controller.dart';

class EmployProfile extends StatelessWidget {
  EmployProfile({super.key});

  final employeeControllr = Get.find<EmployeesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showMenu: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),

        child: Column(
          children: [
            CustomTitel(title: 'Employee Profile', ontap: () {}),
            AppSpacing.vertical30,
            SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(12.r),
                child: Image.asset(AppImages.profileImage),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
