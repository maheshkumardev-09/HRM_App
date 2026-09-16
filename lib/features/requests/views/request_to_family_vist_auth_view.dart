import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/attachment_upload_box.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_container_with_title.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/requests/controllers/requests_controller.dart';
import 'package:hrm_app/features/requests/widgets/custom_request_titel_.dart';
import 'package:hrm_app/features/requests/widgets/row_button.dart';
import 'package:intl/intl.dart';

class RequestToFamilyVistAuthView extends StatelessWidget {
  RequestToFamilyVistAuthView({super.key});
  final requestController = Get.find<RequestsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
          child: Column(
            children: [
              CustomRequestTitel(
                subTitle: 'Request To Family Vist Authentication Request',
              ),
              AppSpacing.vertical30,
              CustomContainerWithTitle(
                titel: 'Subject/Name',
                widget: CustomTextFiled(
                  label: 'Request purpose',
                  controller: requestController.subjectController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Application Submission Date',
                widget: Obx(
                  () => CustomTextFiled(
                    label:
                        requestController.applicationSubmissionDate.value ==
                            null
                        ? 'dd/mm/yyyy'
                        : DateFormat('dd/MM/YYYY').format(
                            requestController.applicationSubmissionDate.value!,
                          ),
                    readOnly: true,

                    onTap: () => requestController
                        .pickApplicationSubmissionDate(context),
                    suffixIcon: Icon(Icons.calendar_today_outlined, size: 20.w),
                  ),
                ),
              ),
              AppSpacing.vertical15,
              Obx(
                () => AttachmentUploadBox(
                  title: 'Visit Document (Attachment)',
                  onTap: () => requestController.pickFile(),
                  selectedFile: requestController.selectedFile.value,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Additional Notes (Family Visit)',
                widget: CustomTextFiled(
                  label: 'Enter any extra details....',
                  maxLines: 5,
                  controller: requestController.descriptionController,
                ),
              ),
              AppSpacing.vertical30,
              Obx(
                () => RowButton(
                  extraFields: {
                    'Application Submission Date':
                        requestController.applicationSubmissionDate.value !=
                            null
                        ? DateFormat('dd/MM/yyyy').format(
                            requestController.applicationSubmissionDate.value!,
                          )
                        : '',
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
