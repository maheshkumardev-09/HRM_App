import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/violations/controllers/violations_controller.dart';
import 'package:hrm_app/routes/app_routes.dart';
import 'package:intl/intl.dart';

class ViolationsView extends StatelessWidget {
  ViolationsView({super.key});
  final violationController = Get.find<ViolationsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
          child: Column(
            children: [
              CustomTitel(title: 'Violation'),
              AppSpacing.vertical30,
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(25.r),
                  color: AppColors.containerBackColor,
                ),
                child: Column(
                  spacing: 10.h,
                  children: [
                    Row(
                      spacing: 10.w,
                      children: [
                        _card(
                          'assets/icon/violations_icon.png',
                          'Total Violations',
                          violationController.totalViolationsCount.toString(),
                        ),
                        _card(
                          'assets/icon/pending_cases_icon.png',
                          'Pending Approvals',
                          violationController.pendingCasesCount.toString(),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 10.w,
                      children: [
                        _card(
                          'assets/icon/approved_cases_icon.png',
                          'Approved Cases',
                          violationController.approvedCasesCount.toString(),
                        ),
                        _card(
                          'assets/icon/payroll_deductions_icon.png',
                          'Payroll Deducatios',
                          violationController.payrollDeductionsCount.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppSpacing.vertical30,
              CustomTextFiled(
                label: 'Search Violation',
                showBorder: false,
                fillColor: AppColors.textfieldColor,
                controller: violationController.searchController,
                prefixIcon: Icon(Icons.search, size: 20.w),
                onChanged: violationController.updateSearch,
              ),
              AppSpacing.vertical20,
              SizedBox(
                height: 36.h,
                child: ListView.builder(
                  itemCount: violationController.statusFilterOptions.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final status =
                        violationController.statusFilterOptions[index];
                    return Obx(() {
                      final isSelected =
                          violationController.selectedStatusFilter.value ==
                          status;
                      return GestureDetector(
                        onTap: () =>
                            violationController.selectStatusFilter(status),
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.r),
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.textfieldColor,
                            ),
                            child: Text(
                              status,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.textColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    });
                  },
                ),
              ),
              AppSpacing.vertical20,
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: violationController.filteredViolations.length,
                  itemBuilder: (context, index) {
                    final data = violationController.filteredViolations[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: GestureDetector(
                        onTap: () => Get.toNamed(
                          AppRoutes.violationdetailsview,
                          arguments: data.id,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(15.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            border: Border.all(color: AppColors.borderColor),
                            color: AppColors.containerBackColor,
                          ),
                          child: Column(
                            spacing: 10.h,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    width: 50.w,
                                    height: 50.w,
                                    child: Image.asset(
                                      'assets/icon/violation_icon.png',
                                      width: 24.w,
                                      height: 24.h,
                                    ),
                                  ),
                                  AppSpacing.horizontal15,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 10.h,
                                      children: [
                                        Text(
                                          data.category,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          data.title,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 5.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.r),
                                      color: violationController.getStatusColor(
                                        data.status,
                                      ),
                                    ),
                                    child: Text(
                                      data.status,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    spacing: 5.h,
                                    children: [
                                      Text(
                                        'Employee',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        data.employeeName,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  AppSpacing.horizontal30,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 5.h,
                                      children: [
                                        Text(
                                          'Date',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          DateFormat(
                                            'yyyy-MM-dd',
                                          ).format(data.date),
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.r),
                                      color: Colors.red,
                                    ),
                                    child: Text(
                                      data.actionTaken,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.whiteColor,
                                      ),
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

  Widget _card(String image, String title, String count) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          color: AppColors.containerBackColordark,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(image, width: 40.w, height: 40.h),
            AppSpacing.horizontal10,
            Column(
              spacing: 10.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  count,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
