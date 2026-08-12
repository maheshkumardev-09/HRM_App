import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/sales/controllers/sales_controller.dart';
import 'package:hrm_app/routes/app_routes.dart';
import 'package:intl/intl.dart';

class SalesView extends StatelessWidget {
  final salescontroller = Get.find<SalesController>();
  SalesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSpacing.vertical30,
              CustomTitel(title: 'Sales Orders'),
              AppSpacing.vertical30,
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  color: AppColors.containerBackColor,
                  border: Border.all(color: AppColors.primaryColor),
                ),
                child: Row(
                  spacing: 10.w,
                  children: [
                    Expanded(
                      child: CustomTextFiled(
                        controller: salescontroller.fromDateController,
                        label: 'From Date',
                        readOnly: true,
                        onTap: () {
                          salescontroller.pickFromDate(context);
                        },
                        suffixIcon: Icon(
                          Icons.calendar_today_outlined,
                          size: 24.w,
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomTextFiled(
                        controller: salescontroller.toDateController,
                        label: 'To Date',
                        readOnly: true,
                        onTap: () {
                          salescontroller.pickToDate(context);
                        },
                        suffixIcon: Icon(
                          Icons.calendar_today_outlined,
                          size: 24.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.vertical30,
              Obx(() {
                final selected = salescontroller.selectedStatus.value;
                return SizedBox(
                  height: 36.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: salescontroller.statusList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => salescontroller.changeStatus(
                          salescontroller.statusList[index],
                        ),
                        child: Container(
                          margin: EdgeInsets.only(right: 10.w),
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.borderColor),
                            color: salescontroller.statusList[index] == selected
                                ? AppColors.primaryColor
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Text(
                            salescontroller.statusList[index],
                            style: TextStyle(
                              color:
                                  salescontroller.statusList[index] ==
                                      salescontroller.selectedStatus.value
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }), //
              AppSpacing.vertical20,
              Obx(
                () => ListView.builder(
                  itemCount: salescontroller.filterSales.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data = salescontroller.filterSales[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.quotationdetailview,
                            arguments: data,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(15.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            color: AppColors.containerBackColor,
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 50.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    child: Image.asset(
                                      AppImages.sales,
                                      height: 24.h,
                                      width: 24.w,
                                    ),
                                  ),
                                  AppSpacing.horizontal15,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Cutomar',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      AppSpacing.vertical5,
                                      Text(
                                        data.clientName,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  AppSpacing.horizontal20,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Date',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        AppSpacing.vertical8,
                                        Text(
                                          DateFormat(
                                            'dd/MM/yyyy',
                                          ).format(data.date),
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
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
                                      color: salescontroller.getStatusColor(
                                        data.status,
                                      ),
                                    ),
                                    child: Text(
                                      data.status,
                                      style: TextStyle(
                                        color: AppColors.whiteColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              AppSpacing.vertical10,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'SR ${data.amount.toString()}',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        AppRoutes.editquotationview,
                                        arguments: {
                                          'sale': data,
                                          'index': index,
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                        vertical: 5.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(
                                          50.r,
                                        ),
                                      ),
                                      child: Text(
                                        'Edit/Pay',
                                        style: TextStyle(
                                          color: AppColors.whiteColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
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
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 60.h,
        width: 60.w,
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppRoutes.newquotationview);
          },
          backgroundColor: AppColors.primaryColor,
          shape: CircleBorder(),
          child: Icon(Icons.add, color: Colors.white, size: 24.w),
        ),
      ),
    );
  }
}
