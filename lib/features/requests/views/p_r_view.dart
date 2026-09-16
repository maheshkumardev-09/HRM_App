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

class PRView extends StatelessWidget {
  PRView({super.key});
  final requestsController = Get.find<RequestsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
          child: Column(
            children: [
              CustomRequestTitel(subTitle: 'PR Request'),
              AppSpacing.vertical30,

              CustomContainerWithTitle(
                titel: 'Subject/Name',
                widget: CustomTextFiled(
                  label: 'Requestn purpose',
                  controller: requestsController.subjectController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Product',
                widget: Obx(
                  () => CustomDropdownField(
                    value: requestsController.selectedPRProduct.value.isEmpty
                        ? null
                        : requestsController.selectedPRProduct.value,
                    hintText: 'Select product ',
                    items: requestsController.prProductOptions,
                    onChanged: (value) {
                      requestsController.selectedPRProduct.value = value!;
                    },
                  ),
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Quantity',
                widget: CustomTextFiled(
                  label: '0.00',
                  controller: requestsController.prQuantityController,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 22.w, vertical: 30.h),
        child: Obx(
          () => RowButton(
            extraFields: {
              'Product': requestsController.selectedPRProduct.value,
              'Quantity': requestsController.prQuantityController.text.trim(),
            },
          ),
        ),
      ),
    );
  }
}
