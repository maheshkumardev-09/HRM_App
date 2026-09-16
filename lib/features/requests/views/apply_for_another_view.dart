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

class ApplyForAnotherView extends StatelessWidget {
  ApplyForAnotherView({super.key});
  final requestcontroller = Get.find<RequestsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
          child: Column(
            children: [
              CustomRequestTitel(subTitle: 'Apply For Another Request'),
              AppSpacing.vertical30,
              CustomContainerWithTitle(
                titel: 'Subject/Name',
                widget: CustomTextFiled(
                  label: 'Request purpose',
                  controller: requestcontroller.subjectController,
                ),
              ),
              AppSpacing.vertical15,
              Obx(
                () => AttachmentUploadBox(
                  title: 'Upload Application PDF',
                  onTap: () => requestcontroller.pickFile(),
                  selectedFile: requestcontroller.selectedFile.value,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Application Notes',
                widget: CustomTextFiled(
                  label: 'Enter any extra details',
                  maxLines: 5,
                  controller: requestcontroller.descriptionController,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w, vertical: 15.h),
        child: RowButton(extraFields: {}),
      ),
    );
  }
}
