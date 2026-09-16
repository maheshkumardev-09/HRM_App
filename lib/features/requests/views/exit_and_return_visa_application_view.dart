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
import 'package:intl/intl.dart';

class ExitAndReturnVisaApplicationView extends StatelessWidget {
  ExitAndReturnVisaApplicationView({super.key});
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
                subTitle: 'Exit and return visa application Request',
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
                titel: 'Order Date',
                widget: Obx(
                  () => CustomTextFiled(
                    label: requestController.visaOrderDate.value == null
                        ? 'dd/mm/yyyy'
                        : DateFormat(
                            'dd/MM/YYYY',
                          ).format(requestController.visaOrderDate.value!),
                    readOnly: true,
                    onTap: () => requestController.pickVisaOrderDate(context),
                  ),
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Visa Type',
                widget: Obx(
                  () => CustomDropdownField(
                    value: requestController.selectedVisaType.value.isEmpty
                        ? null
                        : requestController.selectedVisaType.value,
                    hintText: 'Select Visa Type',
                    items: requestController.visaTypeOptions,
                    onChanged: (value) {
                      requestController.selectedVisaType.value = value!;
                    },
                  ),
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Additional Notes',
                widget: CustomTextFiled(
                  label: 'Enter details about your visa request....',
                  maxLines: 5,
                  controller: requestController.descriptionController,
                ),
              ),
              AppSpacing.vertical30,

              Obx(
                () => RowButton(
                  extraFields: {
                    'Order Date': requestController.visaOrderDate.value != null
                        ? DateFormat(
                            'dd/MM/yyyy',
                          ).format(requestController.visaOrderDate.value!)
                        : '',
                    'Visa Type': requestController.selectedVisaType.value,
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
