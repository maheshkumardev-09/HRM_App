import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/employees/controllers/employees_controller.dart';
import 'package:hrm_app/features/employees/models/employees_model.dart';

class EmployProfileView extends StatelessWidget {
  EmployProfileView({super.key});
  final employeeControllr = Get.find<EmployeesController>();

  @override
  Widget build(BuildContext context) {
    final EmployeesModel employee = Get.arguments;
    // final employee = employeeControllr.getEmployeeById(employeeId);

    // if (employee == null) {
    //   return const Scaffold(body: Center(child: Text('Employee not found')));
    // }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(backgroundColor: AppColors.backgroundColor),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),

        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSpacing.vertical30,
              CustomTitel(title: 'Employee Profile', ontap: () {}),
              AppSpacing.vertical30,
              Container(
                width: 152.w,
                height: 152.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(color: AppColors.primaryColor),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.r),
                  child: Image.asset(AppImages.profileImage, fit: BoxFit.cover),
                ),
              ),
              AppSpacing.vertical20,
              Text(
                employee.name,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
              ),
              AppSpacing.vertical20,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.h),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  spacing: 5.w,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.business_center_outlined,
                      color: AppColors.primaryColor,
                      size: 18.w,
                    ),
                    Text(
                      employee.category,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.vertical30,
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(color: AppColors.primaryColor),
                  color: AppColors.containerBackColordark,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Empoly Emial', style: TextStyle(fontSize: 14.sp)),
                    AppSpacing.vertical10,
                    _infoField(Icons.email_outlined, employee.email),
                    AppSpacing.vertical15,
                    Text('Phone Namber', style: TextStyle(fontSize: 14.sp)),
                    AppSpacing.vertical10,
                    _infoField(Icons.call_outlined, employee.phone),
                    AppSpacing.vertical15,
                    Text('Department', style: TextStyle(fontSize: 14.sp)),
                    AppSpacing.vertical10,
                    _infoField(Icons.description_outlined, employee.department),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoField(IconData icon, String value) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        spacing: 10.w,
        children: [
          Icon(icon, size: 20.w, color: Colors.grey),
          Text(value, style: TextStyle(fontSize: 14.sp)),
        ],
      ),
    );
  }
}
