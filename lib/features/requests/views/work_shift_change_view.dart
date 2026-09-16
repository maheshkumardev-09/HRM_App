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

class WorkShiftChangeView extends StatelessWidget {
  WorkShiftChangeView({super.key});
  final requestController = Get.find<RequestsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomRequestTitel(subTitle: 'Work Shift Change Request'),
              AppSpacing.vertical30,
              CustomContainerWithTitle(
                titel: 'Subject/Name',
                widget: CustomTextFiled(
                  label: 'Request Purpose',
                  controller: requestController.subjectController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Shift Date',
                widget: Obx(
                  () => CustomTextFiled(
                    onTap: () {
                      requestController.pickShiftDate(context);
                    },
                    readOnly: true,
                    label: requestController.shiftDate.value == null
                        ? 'dd/MM/yyyy'
                        : DateFormat(
                            'dd/MM/yyyy',
                          ).format(requestController.shiftDate.value!),
                    suffixIcon: Icon(
                      Icons.calendar_today_outlined,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Shift Start Time',
                widget: Obx(
                  () => CustomTextFiled(
                    label: requestController.shiftStartTime.value == null
                        ? '--:--:--'
                        : requestController.shiftStartTime.value!.format(
                            context,
                          ),
                    onTap: () {
                      requestController.pickShiftStartTime(context);
                    },
                    suffixIcon: Icon(Icons.av_timer_outlined),
                  ),
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'New Shift Selection',
                widget: Obx(
                  () => CustomDropdownField(
                    hintText: 'Select Shift',
                    value: requestController.selectedShift.value.isEmpty
                        ? null
                        : requestController.selectedShift.value,
                    items: requestController.shiftOptions,
                    onChanged: (value) {
                      requestController.selectedShift.value = value!;
                    },
                  ),
                ),
              ),
              AppSpacing.vertical30,
              Obx(
                () => RowButton(
                  extraFields: {
                    'Shift Date': requestController.shiftDate.value != null
                        ? DateFormat(
                            'dd/MM/yyyy',
                          ).format(requestController.shiftDate.value!)
                        : '',
                    'Shift Start Time':
                        requestController.shiftStartTime.value != null
                        ? requestController.shiftStartTime.value!.format(
                            context,
                          )
                        : '',
                    'New Shift Selection':
                        requestController.selectedShift.value,
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
