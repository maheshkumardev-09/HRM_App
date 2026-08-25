import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/expenses/controllers/expenses_controller.dart';
import 'package:hrm_app/routes/app_routes.dart';
import 'package:intl/intl.dart';

class ExpensesView extends StatelessWidget {
  ExpensesView({super.key});
  final expenseController = Get.find<ExpensesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
        child: Column(
          children: [
            CustomTitel(title: 'My Expenses'),
            AppSpacing.vertical30,
            Obx(
              () => Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: AppColors.containerBackColor,
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(color: AppColors.primaryColor),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextFiled(
                        label: expenseController.filterDateFrom.value == null
                            ? 'Date From'
                            : DateFormat(
                                'dd-MM-yyyy',
                              ).format(expenseController.filterDateFrom.value!),
                        readOnly: true,
                        onTap: () =>
                            expenseController.pickFilterDateFrom(context),
                        suffixIcon: Icon(
                          Icons.calendar_today_outlined,
                          size: 22.w,
                        ),
                      ),
                    ),
                    AppSpacing.horizontal10,
                    Expanded(
                      child: CustomTextFiled(
                        label: expenseController.filterDateTo.value == null
                            ? 'Date To'
                            : DateFormat(
                                'dd-MM-yyyy',
                              ).format(expenseController.filterDateTo.value!),
                        readOnly: true,
                        onTap: () =>
                            expenseController.pickFilterDateTo(context),
                        suffixIcon: Icon(
                          Icons.calendar_today_outlined,
                          size: 22.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => expenseController.clearDateFilter(),
                child: Icon(Icons.remove),
              ),
            ),
            AppSpacing.vertical20,
            Obx(
              () => SizedBox(
                height: 36.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: expenseController.statusList.length,
                  itemBuilder: (context, index) {
                    final status = expenseController.statusList[index];
                    final isslected =
                        status == expenseController.selectedStatus.value;
                    return GestureDetector(
                      onTap: () => expenseController.changeStatus(
                        expenseController.statusList[index],
                      ),
                      child: Container(
                        margin: EdgeInsets.only(right: 8.w),
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.borderColor),
                          color: isslected
                              ? AppColors.primaryColor
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Center(
                          child: Text(
                            expenseController.statusList[index],
                            style: TextStyle(
                              color: isslected
                                  ? Colors.white
                                  : Colors.grey.shade500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            AppSpacing.vertical20,
            Expanded(
              child: Obx(() {
                if (expenseController.filteredExpenses.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        Text('Not have expense list'),
                        AppSpacing.vertical15,
                        SizedBox(
                          height: 48.h,
                          width: 130.w,
                          child: CustomButton(
                            title: 'Clear filter',
                            onTap: () => expenseController.clearDateFilter(),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: expenseController.filteredExpenses.length,
                  itemBuilder: (context, index) {
                    final data = expenseController.filteredExpenses[index];
                    return GestureDetector(
                      onLongPress: () =>
                          expenseController.showDeleteDialog(data),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: AppColors.containerBackColor,
                            borderRadius: BorderRadius.circular(25.r),
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 50.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColors.primaryColor,
                                    ),
                                    child: Image.asset(
                                      "assets/icon/expanses.png",
                                    ),
                                  ),
                                  AppSpacing.horizontal15,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'SR ${data.amount.toString()}',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        AppSpacing.vertical5,
                                        Text(
                                          data.description,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 5.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.r),
                                      color: expenseController.getStatusColor(
                                        data.status,
                                      ),
                                    ),
                                    child: Text(
                                      data.status,
                                      style: TextStyle(
                                        color: AppColors.whiteColor,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              AppSpacing.vertical10,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          DateFormat(
                                            'yyyy-MM-dd',
                                          ).format(data.date),
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        AppSpacing.vertical5,
                                        Text(
                                          'Date',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.paidBy,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        AppSpacing.vertical5,
                                        Text(
                                          'PaidBy',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      expenseController.startEdit(data);
                                      Get.toNamed(AppRoutes.editexpensesview);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                        vertical: 5.h,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          50.r,
                                        ),
                                        color: AppColors.primaryColor,
                                      ),
                                      child: Text(
                                        'Edit',
                                        style: TextStyle(
                                          color: AppColors.whiteColor,
                                          fontSize: 12.sp,
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
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 60.w,
        height: 60.h,
        child: FloatingActionButton(
          onPressed: () {
            expenseController.clearForm();
            Get.toNamed(AppRoutes.newexpensesview);
          },
          backgroundColor: AppColors.primaryColor,
          shape: const CircleBorder(),
          child: Icon(Icons.add, color: AppColors.whiteColor),
        ),
      ),
    );
  }
}
