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

class ResignationView extends StatelessWidget {
  ResignationView({super.key});
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
              CustomRequestTitel(subTitle: 'Resignation Request'),
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
                titel: 'Last Working Day',
                widget: Obx(
                  () => CustomTextFiled(
                    label: requestController.lastWorkingDay.value == null
                        ? 'dd/mm/yyyy'
                        : DateFormat(
                            'dd/MM/YYYY',
                          ).format(requestController.lastWorkingDay.value!),
                    readOnly: true,
                    onTap: () => requestController.pickLastWorkingDay(context),
                    suffixIcon: Icon(Icons.calendar_today_outlined, size: 20.w),
                  ),
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Termination Type',
                widget: Obx(
                  () => CustomDropdownField(
                    value:
                        requestController.selectedTerminationType.value.isEmpty
                        ? null
                        : requestController.selectedTerminationType.value,
                    items: requestController.terminationTypeOptions,
                    onChanged: (value) {
                      requestController.selectedTerminationType.value = value!;
                    },
                  ),
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Reason',
                widget: CustomTextFiled(
                  label: 'Justify your reason here...',
                  maxLines: 5,
                  controller: requestController.reasonController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Note',
                widget: CustomTextFiled(
                  label: 'Additional notes here...',
                  maxLines: 5,
                  controller: requestController.descriptionController,
                ),
              ),
              AppSpacing.vertical30,
              Obx(
                () => RowButton(
                  extraFields: {
                    'Last Working Day':
                        requestController.lastWorkingDay.value != null
                        ? DateFormat(
                            'dd/MM/yyyy',
                          ).format(requestController.lastWorkingDay.value!)
                        : '',
                    'Termination Type':
                        requestController.selectedTerminationType.value,
                    'Reason': requestController.reasonController.text.trim(),
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
