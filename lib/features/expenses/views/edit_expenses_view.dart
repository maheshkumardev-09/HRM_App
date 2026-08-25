import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                CustomTitel(title: 'Edit Expense'),
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
                AppSpacing.vertical15,
                CustomContainerWithTitle(
                  titel: 'Description*',
                  widget: CustomTextFiled(
                    label: '',
                    controller: expenseController.descriptionController,
                  ),
                ),
                AppSpacing.vertical15,
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
                AppSpacing.vertical15,
                CustomContainerWithTitle(
                  titel: 'Amount*',
                  widget: CustomTextFiled(
                    label: '300.0',
                    keyboardType: TextInputType.number,
                    controller: expenseController.amountController,
                  ),
                ),
                AppSpacing.vertical15,
                CustomContainerWithTitle(
                  titel: 'Existing Recepits',
                  widget: GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: AppColors.textfieldColor,
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  expenseController.selectedFile.value != null
                                      ? expenseController
                                            .selectedFile
                                            .value!
                                            .path
                                            .split('/')
                                            .last
                                      : (expenseController.selectedFile.value !=
                                                null
                                            ? expenseController
                                                  .selectedFile
                                                  .value!
                                                  .path
                                                  .split('/')
                                                  .last
                                            : 'No receipt attached'),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  expenseController.removeReceipt();
                                },
                                child: Icon(
                                  Icons.delete_forever_outlined,
                                  size: 30.w,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),

                        AppSpacing.vertical15,
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Drop file here and cilck to upload',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  AppSpacing.vertical5,
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
                            ),
                            SizedBox(
                              height: 40.h,
                              width: 114.w,
                              child: CustomButton(
                                title: '+ Add Receipt',
                                onTap: () => expenseController.pickFile(),
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
                  titel: 'Notes',
                  widget: CustomTextFiled(
                    label: 'paid bill',
                    controller: expenseController.noteController,
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
                          onTap: () {
                            Get.back();
                          },
                          buttonColor: Colors.grey.shade300,
                        ),
                      ),
                    ),
                    AppSpacing.horizontal10,
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: () {
                            expenseController.updateExpense();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(15.r),
                            ),
                          ),
                          child: Text(
                            'Update & Submit',
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w500,
                            ),
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
