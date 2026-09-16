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

class LoanView extends StatelessWidget {
  LoanView({super.key});
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
              CustomRequestTitel(subTitle: 'Loan Request'),
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
                titel: 'Loan Start Date',
                widget: Obx(
                  () => CustomTextFiled(
                    label: requestController.loanStartDate.value == null
                        ? 'dd/mm/yyyy'
                        : DateFormat().format(
                            requestController.loanStartDate.value!,
                          ),
                    readOnly: true,
                    onTap: () => requestController.pickLoanStartDate(context),
                    suffixIcon: Icon(Icons.calendar_today_outlined, size: 20.w),
                  ),
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Loan Amount',
                widget: CustomTextFiled(
                  label: '0.00',
                  controller: requestController.loanAmountController,
                  keyboardType: TextInputType.number,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Number of Month(Repayment)',
                widget: CustomTextFiled(
                  label: 'e.g 12',
                  controller: requestController.loanMonthsController,
                  keyboardType: TextInputType.number,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Loan Notes/Reson',
                widget: CustomTextFiled(
                  label: 'Describe Loan purpose...',
                  maxLines: 5,
                  controller: requestController.descriptionController,
                ),
              ),
              AppSpacing.vertical30,
              Obx(
                () => RowButton(
                  extraFields: {
                    'Loan Start Date':
                        requestController.loanStartDate.value != null
                        ? DateFormat(
                            'dd/MM/yyyy',
                          ).format(requestController.loanStartDate.value!)
                        : '',
                    'Loan Amount': requestController.loanAmountController.text
                        .trim(),
                    'Number of Months': requestController
                        .loanMonthsController
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
