import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_container_with_title.dart';
import 'package:hrm_app/components/custom_dropdown_field.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/requests/controllers/requests_controller.dart';
import 'package:hrm_app/features/requests/widgets/custom_request_titel_.dart';
import 'package:hrm_app/features/requests/widgets/row_button.dart';

class GriveanceView extends StatelessWidget {
  GriveanceView({super.key});
  final requestController = Get.find<RequestsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: 22.w,
            vertical: 30.h,
          ),
          child: Column(
            children: [
              CustomRequestTitel(subTitle: 'Request Grivean'),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Subject/Name',
                widget: CustomTextFiled(
                  label: 'Request purpose',
                  controller: requestController.subjectController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Department/Section Name',
                widget: Obx(
                  () => CustomDropdownField(
                    hintText: 'Select Department',
                    value: requestController.selectedDepartment.value.isEmpty
                        ? null
                        : requestController.selectedDepartment.value,
                    items: requestController.departmentOptions,
                    onChanged: (value) {
                      requestController.selectedDepartment.value = value!;
                    },
                  ),
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Subject',
                widget: CustomTextFiled(
                  label: 'e.g Workplace issue',
                  controller: requestController.grievanceSubjectController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Grivevance Description',
                widget: CustomTextFiled(
                  label: 'Describe your issue......',
                  maxLines: 5,
                  controller: requestController.descriptionController,
                ),
              ),
              AppSpacing.vertical30,
              Obx(
                () => RowButton(
                  extraFields: {
                    'Department': requestController.selectedDepartment.value,
                    'Subject': requestController.grievanceSubjectController.text
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
