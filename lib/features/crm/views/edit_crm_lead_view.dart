import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_container_with_title.dart';
import 'package:hrm_app/components/custom_dropdown_field.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/crm/controllers/crm_controller.dart';

class EditCrmLeadView extends StatelessWidget {
  EditCrmLeadView({super.key});
  final crmController = Get.find<CrmController>();
  final String leadId = Get.arguments;
  @override
  Widget build(BuildContext context) {
    final lead = crmController.getLeadById(leadId);
    if (lead == null) {
      return Scaffold(
        appBar: CustomAppBar(),
        body: Center(child: Text('Lead not found')),
      );
    }
    crmController.prefillEditForm(lead);

    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
          child: Column(
            children: [
              CustomTitel(title: 'Edit Lead'),
              AppSpacing.vertical30,
              CustomContainerWithTitle(
                titel: 'Lead Name',
                widget: CustomTextFiled(
                  label: '',
                  controller: crmController.leadNameController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Email',
                widget: CustomTextFiled(
                  label: '',
                  controller: crmController.emailController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Phone Number',
                widget: CustomTextFiled(
                  label: '',
                  controller: crmController.phoneController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Exected Revenue',
                widget: CustomTextFiled(
                  label: '',
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\d{0,2}'),
                    ),
                  ],
                  controller: crmController.revenueController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Stage',
                widget: Obx(
                  () => CustomDropdownField(
                    value: crmController.editStage.value,
                    items: crmController.editStageOptions,
                    onChanged: (value) {
                      crmController.editStage.value = value!;
                    },
                  ),
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Description',
                widget: CustomTextFiled(
                  label: '',
                  controller: crmController.descriptionController,
                ),
              ),
              AppSpacing.vertical30,
              Row(
                spacing: 10.w,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: CustomButton(
                        titleColor: AppColors.textColor,
                        buttonColor: AppColors.textfieldColor,
                        title: 'Cancel',
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: CustomButton(
                        title: 'Save Changes',
                        onTap: () => crmController.editLead(leadId),
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
