import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_dropdown_field.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/employees/controllers/employees_controller.dart';
import 'package:hrm_app/routes/app_routes.dart';

class EmployeesView extends StatelessWidget {
  EmployeesView({super.key});
  final searchController = TextEditingController();
  final employeeController = Get.find<EmployeesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSpacing.vertical30,
              CustomTitel(title: 'Employee Directory'),
              AppSpacing.vertical30,
              Container(
                padding: EdgeInsets.all(20.w),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.containerBackColor,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: AppColors.primaryColor),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/icon/empolyee-icon.png',
                          width: 50.w,
                          height: 50.h,
                          fit: BoxFit.contain,
                        ),
                        AppSpacing.horizontal10,
                        Expanded(
                          child: Text(
                            'Totol Employees',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Text(
                          employeeController.employeeList.length.toString(),
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.vertical15,
                    CustomTextFiled(
                      label: 'Search',
                      fillColor: AppColors.textfieldColor,
                      showBorder: false,
                      onChanged: (value) {
                        employeeController.searchText.value = value;
                        employeeController.apllyFilter();
                      },
                    ),
                    AppSpacing.vertical15,
                    Row(
                      spacing: 10.w,
                      children: [
                        Expanded(
                          child: CustomDropdownField(
                            value: employeeController.selectedDepartment.value,
                            items: employeeController.departmentList,
                            onChanged: (value) {
                              if (value != null) {
                                employeeController.selectedDepartment.value =
                                    value;
                                employeeController.apllyFilter();
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomDropdownField(
                            value: employeeController.selectedPosition.value,
                            items: employeeController.positionList,
                            onChanged: (value) {
                              if (value != null) {
                                employeeController.selectedPosition.value =
                                    value;
                                employeeController.apllyFilter();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppSpacing.vertical20,
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: employeeController.filteredList.length,
                  itemBuilder: (context, index) {
                    final data = employeeController.filteredList[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.empolyeesprofileview,
                            arguments: data,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(15.w),
                          decoration: BoxDecoration(
                            color: AppColors.containerBackColor,
                            borderRadius: BorderRadius.circular(25.r),
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(
                                  15.r,
                                ),
                                child: Image.asset(
                                  AppImages.profileImage,
                                  height: 60.h,
                                  width: 60.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              AppSpacing.horizontal15,
                              Column(
                                spacing: 10.h,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.name,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 5.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),

                                    child: Row(
                                      spacing: 5.w,
                                      children: [
                                        Icon(
                                          Icons.business_center_outlined,
                                          size: 16.w,
                                          color: AppColors.primaryColor,
                                        ),
                                        Text(
                                          data.position,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
