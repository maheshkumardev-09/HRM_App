import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/violations/controllers/violations_controller.dart';
import 'package:intl/intl.dart';

class ViolationDetailsView extends StatelessWidget {
  ViolationDetailsView({super.key});
  final violationController = Get.find<ViolationsController>();

  @override
  Widget build(BuildContext context) {
    final String violationId = Get.arguments;
    final violation = violationController.getViolationById(violationId);
    if (violation == null) {
      return Scaffold(body: Center(child: Text('Violation not found')));
    }
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '(#${violation.id})',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
              AppSpacing.vertical10,
              CustomTitel(title: violation.title),
              AppSpacing.vertical15,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  color: AppColors.primaryColor,
                ),
                child: Text(
                  violation.category,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.whiteColor,
                  ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImages.personIcon),
                    AppSpacing.horizontal15,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10.h,
                        children: [
                          Text(
                            'Employee',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            violation.employeeName,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
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
                          violation.status,
                        ),
                      ),
                      child: Text(
                        violation.status,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.vertical30,
              Divider(color: AppColors.textfieldColor, thickness: 2),
              AppSpacing.vertical30,
              Text(
                'Violation Details',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              AppSpacing.vertical20,
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(color: AppColors.borderColor),
                  color: AppColors.containerBackColor,
                ),
                child: Column(
                  spacing: 20.h,
                  children: [
                    _detailsRow(
                      'Action Taken',
                      violation.actionTaken,
                      textcolor: Colors.red,
                    ),
                    Divider(color: AppColors.textfieldColor, thickness: 2),
                    _detailsRow(
                      'Date',
                      DateFormat('dd/MM/yyyy').format(violation.date),
                    ),
                    Divider(color: AppColors.textfieldColor, thickness: 2),
                    _detailsRow(
                      "Occurrences",
                      violation.occurrences.toString(),
                    ),
                    Divider(color: AppColors.textfieldColor, thickness: 2),
                    _detailsRow(
                      'Deduction %(from Daily rate)',
                      '${violation.deductionPercent.toString()}%',
                    ),
                    Divider(color: AppColors.textfieldColor, thickness: 2),
                    _detailsRow(
                      'Deduction Amount',
                      '${violation.deductionAmount.toString()} SR',
                    ),
                    Divider(color: AppColors.textfieldColor, thickness: 2),
                    _detailsRow(
                      'Deduction Effective Date',
                      violation.deductionEffectiveDate != null
                          ? DateFormat(
                              'dd/MM/yyyy',
                            ).format(violation.deductionEffectiveDate!)
                          : '--',
                    ),
                    Divider(color: AppColors.textfieldColor, thickness: 2),
                    _detailsRow('Notice/Warning', violation.notice ?? '---'),
                  ],
                ),
              ),
              AppSpacing.vertical30,
              SizedBox(
                height: 48.h,
                width: double.infinity,
                child: CustomButton(
                  title: 'Back to Violations',
                  onTap: () => Get.back(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailsRow(String type, String data, {Color? textcolor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          type,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
        ),
        Text(
          data,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: textcolor ?? AppColors.blackColor,
          ),
        ),
      ],
    );
  }
}
