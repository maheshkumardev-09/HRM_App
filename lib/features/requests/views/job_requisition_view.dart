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

class JobRequisitionView extends StatelessWidget {
  JobRequisitionView({super.key});
  final requestController = Get.find<RequestsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            vertical: 30.h,
            horizontal: 22.w,
          ),
          child: Column(
            children: [
              CustomRequestTitel(subTitle: 'Job requition Request'),
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
                titel: 'Job Title',
                widget: Obx(
                  () => CustomDropdownField(
                    value: requestController.selectedJobTitle.value.isEmpty
                        ? null
                        : requestController.selectedJobTitle.value,
                    hintText: 'Select Job Postition',
                    items: requestController.jobTitleOptions,
                    onChanged: (value) {
                      requestController.selectedJobTitle.value = value!;
                    },
                  ),
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Education Level',
                widget: Obx(
                  () => CustomDropdownField(
                    value:
                        requestController.selectedEducationLevel.value.isEmpty
                        ? null
                        : requestController.selectedEducationLevel.value,
                    hintText: 'Select Education Level',
                    items: requestController.educationLevelOptions,
                    onChanged: (vlaue) {
                      requestController.selectedEducationLevel.value = vlaue!;
                    },
                  ),
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Min Years of Experience',
                widget: Obx(
                  () => CustomDropdownField(
                    value: requestController.selectedMinExperience.value.isEmpty
                        ? null
                        : requestController.selectedMinExperience.value,
                    hintText: '0',
                    items: requestController.experienceOptions,
                    onChanged: (value) {
                      requestController.selectedMinExperience.value = value!;
                    },
                  ),
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Requisition Notes',
                widget: CustomTextFiled(
                  label: 'Add your note here....',
                  maxLines: 5,
                  controller: requestController.descriptionController,
                ),
              ),
              AppSpacing.vertical30,
              Obx(
                () => RowButton(
                  extraFields: {
                    'Job Title': requestController.selectedJobTitle.value,
                    'Education Level':
                        requestController.selectedEducationLevel.value,
                    'Min Years of Experience':
                        requestController.selectedMinExperience.value,
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
