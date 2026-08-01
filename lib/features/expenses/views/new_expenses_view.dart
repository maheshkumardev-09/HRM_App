import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
      appBar: CustomAppBar(showMenu: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTitel(title: 'Submit Expense', ontap: () {}),
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
                            checkColor: AppColors.white,
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
                            checkColor: AppColors.white,
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
              AppSpacing.vertical20,
              CustomContainerWithTitle(
                titel: 'Description*',
                widget: CustomTextFiled(
                  label: 'Add description here.....',
                  controller: expenseController.descriptionController,
                ),
              ),
              AppSpacing.vertical20,
              CustomContainerWithTitle(
                titel: 'EXpexses Type*',
                widget: Obx(
                  () => CustomDropdownField(
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
              AppSpacing.vertical20,

              CustomContainerWithTitle(
                titel: 'Amount*',
                widget: CustomTextFiled(
                  keyboardType: TextInputType.number,
                  label: '00.0',
                  controller: expenseController.amountController,
                ),
              ),
              AppSpacing.vertical20,
              CustomContainerWithTitle(
                titel: 'Upload Receipts',
                widget: GestureDetector(
                  onTap: () {
                    expenseController.pickFile();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Obx(
                      () => expenseController.selectedFile.value == null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.green.shade100,
                                  ),
                                  child: Icon(
                                    Icons.file_upload_outlined,
                                    color: AppColors.primaryColor,
                                    size: 24.w,
                                  ),
                                ),
                                Text(
                                  'Drop file here and cilck to upload',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black45,
                                  ),
                                ),
                                AppSpacing.vertical8,
                                Text(
                                  'PDF,PNG,JPG up to 10MB',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              expenseController.selectedFile.value!.path
                                  .split("/")
                                  .last,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              AppSpacing.vertical20,
              CustomContainerWithTitle(
                titel: 'Notes',
                widget: TextField(
                  controller: expenseController.noteController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    hint: Text(
                      'Add any aditional Note',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              AppSpacing.vertical30,
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      title: 'Cancel',
                      titleColor: Colors.black,
                      onTap: () => Get.back(),
                      buttonColor: Colors.grey.shade300,
                    ),
                  ),
                  AppSpacing.horizontal10,
                  Expanded(
                    child: CustomButton(
                      title: 'Crate Lead',
                      onTap: () {
                        expenseController.addNewExpenses();
                      },
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
