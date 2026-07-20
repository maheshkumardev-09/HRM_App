import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custum_app_bar.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/employees/controllers/employees_controller.dart';

class EmployeesView extends StatelessWidget {
  EmployeesView({super.key});
  final searchController = TextEditingController();
  final employeeController = Get.find<EmployeesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showMenu: false),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTitel(title: 'Employee Directory'),
            Container(
              padding: EdgeInsets.all(15.w),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
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
                      ),
                      AppSpacing.horizontal8,
                      Expanded(
                        child: Text(
                          'Totol Employees',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        '71',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.vertical15,
                  CustomTextFiled(
                    label: 'Search',
                    controller: searchController,
                  ),
                  AppSpacing.vertical15,
                  Custom(
                    title: 'All Departments',
                    icon: Icons.keyboard_arrow_down,
                    title2: 'All Job Positions',
                    icon2: Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),
            AppSpacing.vertical20,
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemCount: employeeController.employList.length,
                  shrinkWrap: false,
                  itemBuilder: (context, index) {
                    final data = employeeController.employList[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              AppImages.profileImage,
                              height: 60.h,
                              width: 60.w,
                            ),
                            AppSpacing.horizontal10,
                            Column(
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
                                  margin: EdgeInsets.only(top: 8.h),
                                  padding: EdgeInsets.all(5.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  // width: 144,
                                  // height: 26.h,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.business_center_outlined,
                                        size: 20.w,
                                      ),
                                      AppSpacing.horizontal2,
                                      Text(
                                        data.category,
                                        style: TextStyle(fontSize: 12.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
