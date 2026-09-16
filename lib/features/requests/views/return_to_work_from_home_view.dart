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

class ReturnToWorkFromHomeView extends StatelessWidget {
  ReturnToWorkFromHomeView({super.key});
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
              CustomRequestTitel(subTitle: 'Return To Work From Home Request'),
              AppSpacing.vertical30,
              CustomContainerWithTitle(
                titel: 'Subject/Name',
                widget: CustomTextFiled(
                  label: 'Request porpuse',
                  controller: requestcontroller.subjectController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Return to Work Date',
                widget: Obx(
                  () => CustomTextFiled(
                    label: requestcontroller.returnToWorkDate.value == null
                        ? 'dd/mm/yyyy'
                        : DateFormat(
                            'dd/MM/YYYY',
                          ).format(requestcontroller.returnToWorkDate.value!),
                    suffixIcon: Icon(Icons.calendar_today_outlined),
                    readOnly: true,
                    onTap: () =>
                        requestcontroller.pickReturnToWorkDate(context),
                  ),
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
              'Return to Work Date':
                  requestcontroller.returnToWorkDate.value != null
                  ? DateFormat(
                      'dd/MM/yyyy',
                    ).format(requestcontroller.returnToWorkDate.value!)
                  : '',
            },
          ),
        ),
      ),
    );
  }
}
