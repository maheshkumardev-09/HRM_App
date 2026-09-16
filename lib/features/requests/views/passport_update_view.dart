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

class PassportUpdateView extends StatelessWidget {
  PassportUpdateView({super.key});
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
              CustomRequestTitel(subTitle: 'Passport Update Request'),
              AppSpacing.vertical30,
              CustomContainerWithTitle(
                titel: 'Subject/Name',
                widget: CustomTextFiled(
                  label: 'Request porpuse',
                  controller: requestController.subjectController,
                ),
              ),
              AppSpacing.vertical15,
              Obx(
                () => AttachmentUploadBox(
                  title: 'Upload Appliction PDF',
                  onTap: requestController.pickFile,
                  selectedFile: requestController.selectedFile.value,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Application Notes',
                widget: CustomTextFiled(
                  label: 'Enter details about your application here....',
                  controller: requestController.descriptionController,
                  maxLines: 5,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Order Date',
                widget: Obx(
                  () => CustomTextFiled(
                    label: requestController.passportOrderDate.value == null
                        ? 'dd/mm/yyyy'
                        : DateFormat(
                            'dd/MM/YYYY',
                          ).format(requestController.passportOrderDate.value!),
                    readOnly: true,
                    onTap: () =>
                        requestController.pickPassportOrderDate(context),
                    suffixIcon: Icon(Icons.calendar_today_outlined, size: 20.w),
                  ),
                ),
              ),
              AppSpacing.vertical15,
              Obx(
                () => AttachmentUploadBox(
                  title: 'Attach New Passport',
                  onTap: () => requestController.pickNewPassportFile(),
                  selectedFile: requestController.newPassportFile.value,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Request Notes',
                widget: CustomTextFiled(
                  label: 'Enter notes here...',
                  maxLines: 5,
                  controller: requestController.requestNoteController,
                ),
              ),
              AppSpacing.vertical30,
              Obx(
                () => RowButton(
                  extraFields: {
                    'Order Date':
                        requestController.passportOrderDate.value != null
                        ? DateFormat(
                            'dd/MM/yyyy',
                          ).format(requestController.passportOrderDate.value!)
                        : '',
                    'Request Notes': requestController
                        .requestNoteController
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
