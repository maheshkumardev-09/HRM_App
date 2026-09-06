import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_container_with_title.dart';
import 'package:hrm_app/components/custom_request_titel_.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/requests/controllers/requests_controller.dart';

class SalaryLetterView extends StatelessWidget {
  SalaryLetterView({super.key});
  final requestController = Get.find<RequestsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
        child: Column(
          children: [
            CustomRequestTitel(subTitle: 'Salary Letter Request'),
            AppSpacing.vertical30,
            CustomContainerWithTitle(
              titel: 'Subject/Name',
              widget: CustomTextFiled(
                label: 'Request Purpose',
                controller: requestController.subjectController,
              ),
            ),
            AppSpacing.vertical15,
            // CustomContainerWithTitle(titel: '', widget: ),
          ],
        ),
      ),
    );
  }
}
