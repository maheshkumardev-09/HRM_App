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

class BenefitDisbursementView extends StatelessWidget {
  BenefitDisbursementView({super.key});
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
              CustomRequestTitel(subTitle: 'Benefit Disbursement Request'),
              AppSpacing.vertical30,
              CustomContainerWithTitle(
                titel: 'Suject/Name',
                widget: CustomTextFiled(
                  label: 'Request purpose',
                  controller: requestController.subjectController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Benefit Type',
                widget: Obx(
                  () => CustomDropdownField(
                    value: requestController.selectedBenefitType.value.isEmpty
                        ? null
                        : requestController.selectedBenefitType.value,
                    hintText: 'Select Type',
                    items: requestController.benefitTypeOptions,
                    onChanged: (vlaue) {
                      requestController.selectedBenefitType.value = vlaue!;
                    },
                  ),
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Benefit Description',
                widget: CustomTextFiled(
                  label: 'Describe here...',
                  maxLines: 5,
                  controller: requestController.descriptionController,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 22.w, vertical: 15.h),
        child: Obx(
          () => RowButton(
            extraFields: {
              'Benefit Type': requestController.selectedBenefitType.value,
            },
          ),
        ),
      ),
    );
  }
}
