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

class LetterAuthRequest extends StatelessWidget {
  LetterAuthRequest({super.key});
  final requestController = Get.find<RequestsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomRequestTitel(subTitle: 'Letter Authorization Request'),
              AppSpacing.vertical30,
              CustomContainerWithTitle(
                titel: 'Subject/Name',
                widget: CustomTextFiled(
                  label: 'Request Purpose',
                  controller: requestController.subjectController,
                ),
              ),
              AppSpacing.vertical15,
              AttachmentUploadBox(
                title: 'Upload Attachment',
                onTap: () {
                  requestController.pickFile();
                },
                selectedFile: requestController.selectedFile.value,
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Description',
                widget: CustomTextFiled(
                  label: 'Enter details here....',
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
                        title: 'Submit Request',
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
