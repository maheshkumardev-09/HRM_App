import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/attachment_upload_box.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_container_with_title.dart';
import 'package:hrm_app/components/custom_dropdown_field.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/expenses/controllers/expenses_controller.dart';

class NewExpensesView extends StatelessWidget {
  final expenseController = Get.find<ExpensesController>();

  NewExpensesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTitel(title: 'Submit Expense'),
              AppSpacing.vertical30,
              CustomContainerWithTitle(
                titel: 'Paid By*',
                widget: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: expenseController.isPaidByEmployee.value,
                            activeColor: AppColors.primaryColor,
                            checkColor: AppColors.whiteColor,
                            onChanged: (value) {
                              expenseController.selectEmployee(value!);
                            },
                          ),
                          Text(
                            'Paid By Empoly',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: expenseController.isPaidByCompany.value,
                            activeColor: AppColors.primaryColor,
                            checkColor: AppColors.whiteColor,
                            onChanged: (value) {
                              expenseController.selectCompany(value!);
                            },
                          ),
                          Text(
                            'Paid By Compny',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Description*',
                widget: CustomTextFiled(
                  label: 'Add description here.....',
                  controller: expenseController.descriptionController,
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'EXpexses Type*',
                widget: Obx(
                  () => CustomDropdownField(
                    hintText: 'Select expanse typr',
                    value: expenseController.selectedExpenseType.value.isEmpty
                        ? null
                        : expenseController.selectedExpenseType.value,
                    items: expenseController.expenseType,
                    onChanged: (value) {
                      expenseController.selectedExpenseType.value = value!;
                    },
                  ),
                ),
              ),
              AppSpacing.vertical15,

              CustomContainerWithTitle(
                titel: 'Amount*',
                widget: CustomTextFiled(
                  keyboardType: TextInputType.number,
                  label: '00.0',
                  controller: expenseController.amountController,
                ),
              ),
              AppSpacing.vertical15,
              AttachmentUploadBox(
                title: 'Upload Receipts',
                onTap: () => expenseController.pickFile(),
                selectedFile: expenseController.selectedFile.value,
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Notes',
                widget: TextField(
                  keyboardType: TextInputType.multiline,
                  controller: expenseController.noteController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    hint: Text(
                      'Add any aditional Note',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(15.w),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      borderSide: BorderSide(color: AppColors.primaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      borderSide: BorderSide(color: AppColors.borderColor),
                    ),
                  ),
                ),
              ),
              AppSpacing.vertical30,
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: CustomButton(
                        title: 'Cancel',
                        titleColor: Colors.black,
                        onTap: () => Get.back(),
                        buttonColor: Colors.grey.shade300,
                      ),
                    ),
                  ),
                  AppSpacing.horizontal10,
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: CustomButton(
                        title: 'Submit Expense',
                        onTap: () {
                          expenseController.addNewExpenses();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
