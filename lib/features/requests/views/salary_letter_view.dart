import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_container_with_title.dart';
import 'package:hrm_app/features/requests/widgets/custom_request_titel_.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/requests/controllers/requests_controller.dart';
import 'package:hrm_app/features/requests/widgets/row_button.dart';

class SalaryLetterView extends StatelessWidget {
  SalaryLetterView({super.key});
  final requestController = Get.find<RequestsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomRequestTitel(subTitle: 'Salary Letter Request'),
              AppSpacing.vertical30,
              CustomContainerWithTitle(
                titel: 'Subject/Name',
                widget: CustomTextFiled(
                  label: 'Request Purpose',
                  controller: requestController.subjectController,
                ),
              ),
              AppSpacing.vertical15,
              Obx(
                () => Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: AppColors.containerBackColor,
                    border: Border.all(color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 7.w,
                        children: [
                          Checkbox(
                            activeColor: AppColors.primaryColor,
                            side: BorderSide(
                              color: AppColors.primaryColor,
                              width: 1.5.w,
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                            value: requestController.includeArabicVersion.value,
                            onChanged: (value) {
                              requestController.includeArabicVersion.value =
                                  value!;
                            },
                          ),
                          Text(
                            'Include Arabic Version',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      AppSpacing.vertical15,
                      Row(
                        spacing: 7.w,
                        children: [
                          Checkbox(
                            activeColor: AppColors.primaryColor,
                            side: BorderSide(
                              color: AppColors.primaryColor,
                              width: 1.5.w,
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                            value:
                                requestController.includeEnglishVersion.value,
                            onChanged: (value) {
                              requestController.includeEnglishVersion.value =
                                  value!;
                            },
                          ),
                          Text(
                            'Include English Version',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Directed To (Arabic)',
                widget: CustomTextFiled(
                  label: '',
                  keyboardType: TextInputType.text,
                  controller: requestController.directedToArabicController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Directed To (English)',
                widget: CustomTextFiled(
                  label: '',
                  controller: requestController.directedToEnglishController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Letter Justification',
                widget: CustomTextFiled(
                  label: 'Enter the details here...',
                  controller: requestController.descriptionController,
                  maxLines: 5,
                ),
              ),
              AppSpacing.vertical35,
              Obx(
                () => RowButton(
                  extraFields: {
                    'includeArabicVersion': requestController
                        .includeArabicVersion
                        .value
                        .toString(),
                    'includeEnglishVersion': requestController
                        .includeEnglishVersion
                        .value
                        .toString(),
                    'Directed To (Arabic)': requestController
                        .directedToArabicController
                        .text
                        .trim(),
                    'Directed To (English)': requestController
                        .directedToEnglishController
                        .text
                        .trim(),
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
