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

class TrainingCourseView extends StatelessWidget {
  TrainingCourseView({super.key});
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
              CustomRequestTitel(subTitle: 'Traning Course Request'),
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
                titel: 'Course Title',
                widget: CustomTextFiled(
                  label: 'e.g Odoo Technical Training',
                  controller: requestController.courseTitleController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Country',
                widget: Obx(
                  () => CustomDropdownField(
                    value:
                        requestController.selectedTrainingCountry.value?.name,
                    hintText: 'Select Country',
                    items: requestController.trainingCountries
                        .map((c) => c.name)
                        .toList(),
                    onChanged: (name) {
                      final country = requestController.trainingCountries
                          .firstWhereOrNull((c) => c.name == name);
                      if (country != null) {
                        requestController.selectTrainingCountry(country);
                      }
                    },
                  ),
                ),
              ),
              AppSpacing.vertical15,
              Row(
                spacing: 10.w,
                children: [
                  Expanded(
                    child: CustomContainerWithTitle(
                      titel: 'From Date',
                      widget: Obx(
                        () => CustomTextFiled(
                          label:
                              requestController.trainingFromDate.value == null
                              ? 'dd/mm/yyyy'
                              : DateFormat('dd/MM/YYYY').format(
                                  requestController.trainingFromDate.value!,
                                ),
                          readOnly: true,
                          onTap: () =>
                              requestController.pickTrainingFromDate(context),
                          suffixIcon: Icon(
                            Icons.calendar_today_outlined,
                            size: 20.w,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomContainerWithTitle(
                      titel: 'To Date',
                      widget: Obx(
                        () => CustomTextFiled(
                          label: requestController.trainingToDate.value == null
                              ? 'dd/mm/yyyy'
                              : DateFormat('dd/MM/YYYY').format(
                                  requestController.trainingToDate.value!,
                                ),
                          readOnly: true,
                          onTap: () =>
                              requestController.pickTrainingToDate(context),
                          suffixIcon: Icon(
                            Icons.calendar_today_outlined,
                            size: 20.w,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Justification',
                widget: CustomTextFiled(
                  label: 'Why is this training needed',
                  maxLines: 5,
                  controller: requestController.justificationController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Course Description',
                widget: CustomTextFiled(
                  label: 'Additional details',
                  maxLines: 5,
                  controller: requestController.descriptionController,
                ),
              ),
              AppSpacing.vertical30,
              Obx(
                () => RowButton(
                  extraFields: {
                    'Course Title': requestController.courseTitleController.text
                        .trim(),
                    'Country':
                        requestController.selectedTrainingCountry.value?.name ??
                        '',
                    'From Date':
                        requestController.trainingFromDate.value != null
                        ? DateFormat(
                            'dd/MM/yyyy',
                          ).format(requestController.trainingFromDate.value!)
                        : '',
                    'To Date': requestController.trainingToDate.value != null
                        ? DateFormat(
                            'dd/MM/yyyy',
                          ).format(requestController.trainingToDate.value!)
                        : '',
                    'Justification': requestController
                        .justificationController
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
