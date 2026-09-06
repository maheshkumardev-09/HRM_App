import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_container_with_title.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/requests/controllers/requests_controller.dart';
import 'package:hrm_app/features/requests/models/request_model.dart';
import 'package:intl/intl.dart';

class RequestDetailsView extends StatelessWidget {
  RequestDetailsView({super.key});
  final controller = Get.find<RequestsController>();

  @override
  Widget build(BuildContext context) {
    final RequestModel request = Get.arguments;
    // final String? attachmentPath;
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 22.w, vertical: 30.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '(#00${request.id})',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              AppSpacing.vertical10,
              Text(
                request.subject,
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              AppSpacing.vertical15,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: controller.getStatusColor(request.status),
                ),
                child: Text(
                  request.status,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
              AppSpacing.vertical15,
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Date',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        DateFormat('dd-MM-yyyy').format(request.startDate),
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
                          DateFormat('dd-MM-yyyy').format(request.endDate),
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
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: AppColors.containerBackColordark,
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(color: AppColors.primaryColor),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.personIcon,
                      height: 50.h,
                      width: 50.w,
                    ),
                    AppSpacing.horizontal15,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Owner',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        AppSpacing.vertical10,
                        Text(
                          request.employeeName,
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
              Divider(thickness: 2, color: AppColors.borderColor),
              AppSpacing.vertical30,
              CustomContainerWithTitle(
                titel: 'Category',
                widget: CustomTextFiled(
                  label: request.requestType,
                  readOnly: true,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Support Document',
                widget: CustomTextFiled(
                  label: request.attachmentPath ?? 'No document attached',
                  showBorder: false,
                  fillColor: AppColors.textfieldColor,
                  readOnly: true,
                  suffixIcon: Icon(Icons.delete_forever, color: Colors.red),
                ),
              ),
              AppSpacing.vertical35,
              SizedBox(
                height: 48.h,
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
