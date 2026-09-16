import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_container_with_title.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/requests/controllers/requests_controller.dart';
import 'package:hrm_app/features/requests/widgets/custom_request_titel_.dart';
import 'package:hrm_app/features/requests/widgets/row_button.dart';
import 'package:intl/intl.dart';

class OutOffOfficeView extends StatelessWidget {
  OutOffOfficeView({super.key});
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
              CustomRequestTitel(subTitle: 'Request Out of office'),
              AppSpacing.vertical30,
              CustomContainerWithTitle(
                titel: 'Subject/Name',
                widget: CustomTextFiled(
                  label: 'Request purpose',
                  controller: requestController.subjectController,
                ),
              ),
              CustomContainerWithTitle(
                titel: 'OOO Date',
                widget: Obx(
                  () => CustomTextFiled(
                    label: requestController.oooDate.value == null
                        ? 'dd/mm/yyyy'
                        : DateFormat(
                            'dd/MM/YYYY',
                          ).format(requestController.oooDate.value!),
                    suffixIcon: Icon(Icons.calendar_today_outlined, size: 20.w),
                    readOnly: true,
                    onTap: () => requestController.pickOooDate(context),
                  ),
                ),
              ),
              AppSpacing.vertical15,
              Row(
                spacing: 10.w,
                children: [
                  Expanded(
                    child: CustomContainerWithTitle(
                      titel: 'From Time',
                      widget: Obx(
                        () => CustomTextFiled(
                          label: requestController.fromTime.value == null
                              ? '--:--:--'
                              : requestController.fromTime.value!.format(
                                  context,
                                ),
                          suffixIcon: Icon(Icons.av_timer_outlined, size: 20.w),
                          readOnly: true,
                          onTap: () => requestController.pickFromTime(context),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomContainerWithTitle(
                      titel: 'To Time',
                      widget: Obx(
                        () => CustomTextFiled(
                          label: requestController.toTime.value == null
                              ? '--:--:--'
                              : requestController.toTime.value!.format(context),
                          suffixIcon: Icon(Icons.av_timer_outlined, size: 20.w),
                          readOnly: true,
                          onTap: () => requestController.pickToTime(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Description',
                widget: CustomTextFiled(
                  label: 'Describe here...',
                  maxLines: 5,
                  controller: requestController.descriptionController,
                ),
              ),
              AppSpacing.vertical30,
              Obx(
                () => RowButton(
                  extraFields: {
                    'OOO Date': requestController.oooDate.value != null
                        ? DateFormat(
                            'dd/MM/yyyy',
                          ).format(requestController.oooDate.value!)
                        : '',
                    'From Time': requestController.fromTime.value != null
                        ? requestController.fromTime.value!.format(context)
                        : '',
                    'To Time': requestController.toTime.value != null
                        ? requestController.toTime.value!.format(context)
                        : '',
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
