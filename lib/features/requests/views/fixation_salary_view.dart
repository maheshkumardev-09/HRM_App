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

class FixationSalaryView extends StatelessWidget {
  FixationSalaryView({super.key});
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
              CustomRequestTitel(subTitle: 'Fixation Salary REquest'),
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
                titel: 'Salary Fixation Notes',
                widget: CustomTextFiled(
                  label: 'Expalin Salary Adjustments',
                  maxLines: 5,
                  controller: requestController.descriptionController,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 22.w, vertical: 15.h),
        child: RowButton(extraFields: {}),
      ),
    );
  }
}
