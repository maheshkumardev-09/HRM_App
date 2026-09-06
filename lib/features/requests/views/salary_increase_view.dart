import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/attachment_upload_box.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_container_with_title.dart';
import 'package:hrm_app/components/custom_request_titel_.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/requests/controllers/requests_controller.dart';

class SalaryIncreaseView extends StatelessWidget {
  SalaryIncreaseView({super.key});
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
              CustomRequestTitel(subTitle: 'salary increase request'),
              AppSpacing.vertical30,
              CustomContainerWithTitle(
                titel: 'Subject/Name ',
                widget: CustomTextFiled(
                  label: 'Request Purpose',
                  controller: requestController.subjectController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Proposed Increment Date',
                widget: CustomTextFiled(
                  label: 'dd/mm/yyyy',
                  suffixIcon: Icon(Icons.calendar_today_outlined, size: 20.w),
                ),
              ),
              AppSpacing.vertical15,
              AttachmentUploadBox(
                title: 'Support Document',
                onTap: () {
                  requestController.pickFile();
                },
                selectedFile: requestController.selectedFile.value,
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Justification Details',
                widget: CustomTextFiled(
                  label: 'Explain the details here....',
                  maxLines: 5,
                  controller: requestController.descriptionController,
                ),
              ),
              AppSpacing.vertical60,
              Row(
                spacing: 10.w,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: CustomButton(
                        title: 'Cancel',
                        onTap: () {
                          requestController.clearForm();
                          Get.back();
                        },
                        titleColor: Colors.black54,
                        buttonColor: AppColors.gary200Color,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: CustomButton(
                        title: 'Submit request',
                        onTap: () {
                          requestController.submitRequest();
                        },
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
  }
}
