import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_row_container.dart';
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
        padding: EdgeInsets.all(20.w),
        child: Obx(() {
          return Column(
            children: [
              CustomTitel(title: 'My Expenses', ontap: () {}),
              AppSpacing.vertical20,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: CustomRowContainer(
                  onTap1: () {},
                  title: 'Date From',
                  icon: Icons.calendar_today_outlined,
                  onTap2: () {},
                  title2: 'Date To',
                  icon2: Icons.calendar_today_outlined,
                ),
              ),
              AppSpacing.vertical20,

              SizedBox(
                height: 30.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: expenseController.statusList.length,
                  itemBuilder: (context, index) {
                    final status = expenseController.statusList[index];
                    return GestureDetector(
                      onTap: () => expenseController.changeStatus(
                        expenseController.statusList[index],
                      ),
                      child: Container(
                        margin: EdgeInsets.only(right: 8.w),
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          color:
                              status == expenseController.selectedStatus.value
                              ? expenseController.getStatusColor(status)
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Center(
                          child: Text(
                            expenseController.statusList[index],
                            style: TextStyle(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              AppSpacing.vertical20,
              Expanded(
                child: ListView.builder(
                  itemCount: expenseController.filteredExpenses.length,
                  itemBuilder: (context, index) {
                    final data = expenseController.filteredExpenses[index];
                    return GestureDetector(
                      onLongPress: () =>
                          expenseController.showDeleteDialog(data),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 8.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColors.primaryColor,
                                    ),

                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 24.w,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                  AppSpacing.horizontal20,
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
                                        AppSpacing.vertical8,
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
                                      horizontal: 16.w,
                                      vertical: 8.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        DateFormat(
                                          'yyyy/MM/dd',
                                        ).format(data.date),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      AppSpacing.vertical8,
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
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          data.paidBy,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        AppSpacing.vertical8,
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
                                      padding: EdgeInsets.all(8.w),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
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
                ),
              ),
              AppSpacing.vertical30,
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          expenseController.clearForm();
          Get.toNamed(AppRoutes.newexpensesview);
        },
        backgroundColor: AppColors.primaryColor,
        shape: const CircleBorder(),
        child: Icon(Icons.add, color: AppColors.whiteColor),
      ),
    );
  }
}
