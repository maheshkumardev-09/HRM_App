import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_2.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_container_with_title.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_spacing.dart';

class RequestDetailsView extends StatelessWidget {
  const RequestDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 15.w, vertical: 30.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '(#001)',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              AppSpacing.vertical10,
              Text(
                'Increst salry',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              AppSpacing.vertical16,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.primaryColor,
                ),
                child: Text(
                  'Aproved',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
              AppSpacing.vertical16,
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Staet Date',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '20-06-2026',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.horizontal40,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'End Date',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '20-06-2026',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              AppSpacing.vertical30,
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColors.gary200Color,
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: AppColors.primaryColor),
                ),
                child: ListTile(
                  leading: Image.asset(AppImages.personIcon),
                  title: Text(
                    'Owner',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    'M. Ahmad',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              AppSpacing.vertical30,
              Divider(thickness: 2, color: Colors.grey.shade300),
              AppSpacing.vertical30,
              CustomContainerWithTitle(
                titel: 'Category',
                widget: CustomTextFiled(
                  label: '',
                  controller: TextEditingController(),
                ),
              ),
              AppSpacing.vertical20,
              CustomContainerWithTitle(
                titel: 'Support Document',
                widget: Custom2(
                  titel: 'Docoments',
                  icon: Icons.delete,
                  color: Colors.red,
                  onTap: () {},
                ),
              ),
              AppSpacing.vertical60,
              SizedBox(
                height: 40.h,
                width: double.infinity,
                child: CustomButton(
                  title: 'Back to List',
                  onTap: () {
                    Get.back();
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
