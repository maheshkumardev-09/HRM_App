import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_2.dart';
import 'package:hrm_app/components/custom_dropdown_field.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_container_with_title.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/expenses/controllers/expenses_controller.dart';

class EditExpensesView extends StatelessWidget {
  EditExpensesView({super.key});
  final expenseController = Get.find<ExpensesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showMenu: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                CustomTitel(title: 'Edit Expense', ontap: () {}),
                AppSpacing.vertical30,
                CustomContainerWithTitle(
                  titel: 'Paid By*',
                  widget: Row(
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
                AppSpacing.vertical20,
                CustomContainerWithTitle(
                  titel: 'Description*',
                  widget: CustomTextFiled(
                    label: '',
                    controller: expenseController.descriptionController,
                  ),
                ),
                AppSpacing.vertical20,
                CustomContainerWithTitle(
                  titel: 'EXpexses Type*',
                  widget: CustomDropdownField(
                    value: expenseController.selectedExpenseType.value.isEmpty
                        ? null
                        : expenseController.selectedExpenseType.value,
                    items: expenseController.expenseType,
                    onChanged: (value) {
                      expenseController.selectedExpenseType.value = value!;
                    },
                  ),
                ),
                AppSpacing.vertical20,
                CustomContainerWithTitle(
                  titel: 'Amount*',
                  widget: CustomTextFiled(
                    label: '300.0',
                    controller: expenseController.amountController,
                  ),
                ),
                AppSpacing.vertical20,
                CustomContainerWithTitle(
                  titel: 'Existing Recepits',
                  widget: GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        Custom2(
                          titel: expenseController.selectedFile.value == null
                              ? "No file selected"
                              : expenseController.selectedFile.value!.path
                                    .split('/')
                                    .last,
                          icon: Icons.delete_forever_outlined,
                          color: Colors.red,
                          onTap: () {
                            expenseController.selectedFile.value = null;
                          },
                        ),
                        AppSpacing.vertical8,
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Drop file here and cilck to upload',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                AppSpacing.vertical8,
                                Text(
                                  'PDF,PNG,JPG up to 10MB',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                            AppSpacing.horizontal10,
                            ElevatedButton(
                              onPressed: () {
                                expenseController.pickFile();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    12.r,
                                  ),
                                ),
                              ),
                              child: Text(
                                '+AddRecepit',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10.sp,
                                ),
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
                  titel: 'Notes',
                  widget: TextField(
                    controller: expenseController.noteController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      hint: Text(
                        'paid Bill',
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
                        onTap: () {
                          Get.back();
                        },
                        buttonColor: Colors.grey.shade300,
                      ),
                    ),
                    AppSpacing.horizontal10,
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          expenseController.updateExpense();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Update & Submit',
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
