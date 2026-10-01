import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_container_with_title.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/crm/controllers/crm_controller.dart';

class AddCRMView extends StatelessWidget {
  AddCRMView({super.key});
  final crmController = Get.find<CrmController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
          child: Column(
            children: [
              CustomTitel(title: 'Create a New Lead'),
              AppSpacing.vertical30,
              CustomContainerWithTitle(
                titel: 'Lead Name',
                widget: CustomTextFiled(
                  label: 'Enter Lead Name',
                  controller: crmController.leadNameController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Customer',
                widget: CustomTextFiled(
                  label: 'Enter Customer Name',
                  controller: crmController.customerController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Expected Revenue',
                widget: CustomTextFiled(
                  label: '0.00',
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  controller: crmController.revenueController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Email',
                widget: CustomTextFiled(
                  label: 'abc123@gmail.com',
                  keyboardType: TextInputType.emailAddress,
                  controller: crmController.emailController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Phone',
                widget: CustomTextFiled(
                  label: '+923461231794',
                  keyboardType: TextInputType.phone,
                  controller: crmController.phoneController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Description',
                widget: CustomTextFiled(
                  label: 'Enter your description here...',
                  controller: crmController.descriptionController,
                  maxLines: 5,
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
                        title: 'Cancel',
                        onTap: () {
                          crmController.clearForm();
                          Get.back();
                        },
                        titleColor: AppColors.textColor,
                        buttonColor: AppColors.textfieldColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: CustomButton(
                        title: 'Create Lead',
                        onTap: () => crmController.createLead(),
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
