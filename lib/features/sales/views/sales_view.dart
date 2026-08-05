import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_row_container.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTitel(title: 'Sales Orders', ontap: () {}),
              AppSpacing.vertical30,
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.grey.shade200,
                ),
                child: CustomRowContainer(
                  title: 'Date From',
                  icon: Icons.calendar_today_outlined,
                  title2: 'Date To',
                  icon2: Icons.calendar_today_outlined,
                  onTap1: () {},
                  onTap2: () {},
                ),
              ),
              AppSpacing.vertical30,
              Obx(() {
                final selected = salescontroller.selectedStatus.value;
                return SizedBox(
                  height: 30.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: salescontroller.statusList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => salescontroller.changeStatus(
                          salescontroller.statusList[index],
                        ),
                        child: Container(
                          margin: EdgeInsets.only(right: 8.w),
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            color: salescontroller.statusList[index] == selected
                                ? AppColors.primaryColor
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Center(
                            child: Text(
                              salescontroller.statusList[index],
                              style: TextStyle(
                                color:
                                    salescontroller.statusList[index] ==
                                        salescontroller.selectedStatus.value
                                    ? Colors.white
                                    : Colors.black,
                              ),
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
                  itemCount: salescontroller.filteredSalesList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data = salescontroller.filteredSalesList[index];
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
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 20.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: Colors.grey.shade200,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10.w),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Image.asset(
                                      AppImages.sales,
                                      fit: BoxFit.cover,
                                      height: 24.h,
                                      width: 24.w,
                                    ),
                                  ),
                                  AppSpacing.horizontal10,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Cutomar',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      AppSpacing.vertical8,
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
                                  AppSpacing.horizontal10,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Date',
                                          style: TextStyle(
                                            fontSize: 14.sp,
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
                                    padding: EdgeInsets.all(6.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: salescontroller.getStatusColor(
                                        data.status,
                                      ),
                                    ),
                                    child: Text(
                                      data.status,
                                      style: TextStyle(
                                        color: AppColors.white,
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
                                  SizedBox(
                                    height: 25.h,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.toNamed(
                                          AppRoutes.editquotationview,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor,
                                      ),
                                      child: Text(
                                        'Edit/Pay',
                                        style: TextStyle(
                                          color: AppColors.white,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.newquotationview);
        },
        backgroundColor: AppColors.primaryColor,
        shape: const CircleBorder(),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
