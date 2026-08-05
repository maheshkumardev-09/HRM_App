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
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),

        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTitel(title: 'Employee Profile', ontap: () {}),
              AppSpacing.vertical30,
              Container(
                width: 150.w,
                height: 140.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: AppColors.primaryColor),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(AppImages.profileImage, fit: BoxFit.cover),
                ),
              ),
              AppSpacing.vertical20,
              Text(
                employee.name,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
              ),
              AppSpacing.vertical10,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.business_center_outlined,
                      color: AppColors.primaryColor,
                    ),
                    AppSpacing.horizontal8,
                    Text(
                      employee.category,
                      style: TextStyle(
                        fontSize: 12.sp,
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
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.primaryColor),
                  color: Colors.grey.shade100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Empoly Emial', style: TextStyle(fontSize: 13.sp)),
                    AppSpacing.vertical8,
                    _infoField(Icons.email_outlined, employee.email),
                    AppSpacing.vertical15,
                    Text('Phone', style: TextStyle(fontSize: 13.sp)),
                    AppSpacing.vertical8,
                    _infoField(Icons.call_outlined, employee.phone),
                    AppSpacing.vertical15,
                    Text('Department', style: TextStyle(fontSize: 13.sp)),
                    AppSpacing.vertical8,
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
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: Colors.grey),
          SizedBox(width: 10.w),
          Text(value, style: TextStyle(fontSize: 14.sp)),
        ],
      ),
    );
  }
}
