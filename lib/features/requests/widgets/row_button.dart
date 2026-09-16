import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/features/requests/controllers/requests_controller.dart';

class RowButton extends StatelessWidget {
  final Map<String, String> extraFields;

  RowButton({super.key, this.extraFields = const {}});
  final requestController = Get.find<RequestsController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      children: [
        Expanded(
          child: SizedBox(
            height: 48.h,
            child: CustomButton(
              title: 'Cancel',
              onTap: () {
                requestController.clearForm();
                Get.back();
              },
              titleColor: Colors.black54,
              buttonColor: AppColors.gary200Color,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 48.h,
            child: CustomButton(
              title: 'Submit request',
              onTap: () {
                requestController.submitRequest(extraFields: extraFields);
              },
            ),
          ),
        ),
      ],
    );
  }
}
