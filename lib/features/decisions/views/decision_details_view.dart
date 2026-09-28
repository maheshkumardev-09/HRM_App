import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/decisions/controllers/decisions_controller.dart';
import 'package:intl/intl.dart';

class DecisionDetailsView extends StatelessWidget {
  DecisionDetailsView({super.key});
  final decisionController = Get.find<DecisionsController>();
  @override
  Widget build(BuildContext context) {
    final String getId = Get.arguments;
    final data = decisionController.getDecisionById(getId);
    if (data == null) {
      return Center(child: Text('Not have data'));
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
                'DEC#${data.id}',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
              AppSpacing.vertical10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.title,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: decisionController.getStatusColor(data.status),
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
              AppSpacing.vertical15,
              Text(
                'Date',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
              ),
              AppSpacing.vertical10,
              Text(
                DateFormat('MM/dd/yyyy').format(data.date),
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
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
                  children: [
                    Image.asset(
                      AppImages.personIcon,
                      width: 50.w,
                      height: 50.h,
                    ),
                    AppSpacing.horizontal15,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10.h,
                      children: [
                        Text(
                          'Employee',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          data.employeeName,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppSpacing.vertical30,
              Divider(color: AppColors.textfieldColor, thickness: 2),
              AppSpacing.vertical30,
              Text(
                'Quick Info',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _detailsRow('Approved By', data.approvedBy ?? '---'),
                    Divider(color: AppColors.borderColor, thickness: 2),
                    _detailsRow(
                      'Approved Date',
                      data.approvedDate != null
                          ? DateFormat(
                              'MM/dd/yyyy  hh:mm:ss a',
                            ).format(data.approvedDate!)
                          : '---',
                    ),
                    Divider(color: AppColors.borderColor, thickness: 2),
                    _detailsRow('Rejected By', data.rejectedBy ?? '---'),
                    Divider(color: AppColors.borderColor, thickness: 2),
                    _detailsRow(
                      'Rejected Date',
                      data.rejectedDate != null
                          ? DateFormat(
                              'MM/dd/yyyy  hh:mm:ss a',
                            ).format(data.rejectedDate!)
                          : '---',
                    ),
                  ],
                ),
              ),
              AppSpacing.vertical30,
              SizedBox(
                height: 48.h,
                width: double.infinity,
                child: CustomButton(
                  title: 'Back to Decisions',
                  onTap: () => Get.back(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailsRow(String type, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          type,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
        ),
        Text(
          data,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
