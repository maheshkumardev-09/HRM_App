import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/payroll/controllers/payroll_controller.dart';
import 'package:intl/intl.dart';

class PayrollView extends StatelessWidget {
  final payrollController = Get.find<PayrollController>();
  PayrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showBack: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacing.vertical30,
              CustomTitel(title: 'Payroll'),
              AppSpacing.vertical30,
              Obx(() {
                final lastPayroll = payrollController.payrollList.last;
                if (payrollController.payrollList.isEmpty) {
                  return const Text('No Payroll Found');
                }
                return Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    border: Border.all(color: AppColors.primaryColor),
                    color: AppColors.containerBackColor,
                  ),
                  child: Column(
                    spacing: 20.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Last PaySlip',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                          color: AppColors.containerBackColordark,
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              AppImages.payroll,
                              height: 50.h,
                              width: 50.w,
                            ),
                            AppSpacing.horizontal15,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'SR ${lastPayroll.payment.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  AppSpacing.vertical10,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        DateFormat(
                                          'MMMM yyyy',
                                        ).format(lastPayroll.dateTo),
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 5.h,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            50.r,
                                          ),
                                          color: Colors.green,
                                        ),
                                        child: Text(
                                          lastPayroll.status,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: AppColors.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: () {
                            payrollController.payrollPdf(lastPayroll);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(12),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.download_for_offline_outlined,
                                color: AppColors.whiteColor,
                                size: 25.w,
                              ),
                              AppSpacing.horizontal8,
                              Text(
                                'Download PDF',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              AppSpacing.vertical30,
              Text(
                'My Payslips',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              AppSpacing.vertical20,
              Obx(() {
                final list = payrollController.payrollList.reversed.toList();
                return ListView.builder(
                  itemCount: list.length - 1,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data = list[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
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
                                    borderRadius: BorderRadius.circular(15.sp),
                                    color: AppColors.primaryColor,
                                  ),
                                  child: Image.asset(
                                    'assets/icon/bill.png',
                                    height: 24.h,
                                    width: 24.w,
                                  ),
                                ),
                                AppSpacing.horizontal15,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat(
                                        'yyy-MM-dd',
                                      ).format(data.dateFrom),
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    AppSpacing.vertical5,
                                    Text(
                                      'Date From',
                                      style: TextStyle(fontSize: 10.sp),
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
                                        DateFormat(
                                          'yyy-MM-dd',
                                        ).format(data.dateTo),
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                      ),
                                      AppSpacing.vertical8,
                                      Text(
                                        'Date To',
                                        style: TextStyle(fontSize: 10.sp),
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
                                    borderRadius: BorderRadius.circular(50.w),
                                    color: payrollController.statusColors(
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
                            AppSpacing.vertical20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'SR ${data.payment.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    payrollController.payrollPdf(data);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 5.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.r),
                                      color: AppColors.primaryColor,
                                    ),
                                    child: Text(
                                      'Download PDF',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
