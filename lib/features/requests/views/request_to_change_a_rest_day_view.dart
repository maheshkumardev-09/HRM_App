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

class RequestToChangeARestDayView extends StatelessWidget {
  RequestToChangeARestDayView({super.key});
  final requestcontroller = Get.find<RequestsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
          child: Column(
            children: [
              CustomRequestTitel(subTitle: ' Request to change a rest day'),
              AppSpacing.vertical30,
              CustomContainerWithTitle(
                titel: 'Subject/Name',
                widget: CustomTextFiled(
                  label: 'Request purpose',
                  controller: requestcontroller.subjectController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'the rest day to be replaced',
                widget: Obx(
                  () => CustomTextFiled(
                    label: requestcontroller.restDayToReplace.value == null
                        ? 'dd/mm/yyyy'
                        : DateFormat(
                            'dd/MM/YYYY',
                          ).format(requestcontroller.restDayToReplace.value!),
                    readOnly: true,
                    onTap: () =>
                        requestcontroller.pickRestDayToReplace(context),
                    suffixIcon: Icon(Icons.calendar_today_outlined, size: 20.w),
                  ),
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Workday to assignrd',
                widget: Obx(
                  () => CustomTextFiled(
                    label: requestcontroller.workdayToAssign.value == null
                        ? 'dd/mm/yyyy'
                        : DateFormat(
                            'dd/MM/YYYY',
                          ).format(requestcontroller.workdayToAssign.value!),
                    readOnly: true,
                    onTap: () => requestcontroller.pickWorkdayToAssign(context),
                    suffixIcon: Icon(Icons.calendar_today_outlined, size: 20.w),
                  ),
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Work shift',
                widget: CustomTextFiled(
                  label: 'e.g 8:00 AM-5:00 PM',
                  controller: requestcontroller.workShiftController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Additional Notes',
                widget: CustomTextFiled(
                  label: 'Additional Notes here...',
                  maxLines: 5,
                  controller: requestcontroller.descriptionController,
                ),
              ),
              AppSpacing.vertical30,
              Obx(
                () => RowButton(
                  extraFields: {
                    'Rest Day to Replace':
                        requestcontroller.restDayToReplace.value != null
                        ? DateFormat(
                            'dd/MM/yyyy',
                          ).format(requestcontroller.restDayToReplace.value!)
                        : '',
                    'Workday to Assign':
                        requestcontroller.workdayToAssign.value != null
                        ? DateFormat(
                            'dd/MM/yyyy',
                          ).format(requestcontroller.workdayToAssign.value!)
                        : '',
                    'Work Shift': requestcontroller.workShiftController.text
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
