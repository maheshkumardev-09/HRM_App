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
  final payrollControllr = Get.find<PayrollController>();
  PayrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showMenu: false),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitel(title: 'Payroll', ontap: () {}),
              AppSpacing.vertical30,
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.primaryColor),
                  color: Colors.grey.shade100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Last PaySlip',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    AppSpacing.vertical20,
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.grey.shade200,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.w),
                            child: Image.asset(AppImages.payroll),
                          ),
                          AppSpacing.horizontal10,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SR 295.00',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                AppSpacing.vertical10,
                                Text(
                                  'April 2026',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 8.0.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.sp),
                              color: Colors.green,
                            ),
                            child: Text(
                              'Paid',
                              style: TextStyle(color: AppColors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppSpacing.vertical20,
                    SizedBox(
                      width: double.infinity,
                      height: 40.h,
                      child: ElevatedButton(
                        onPressed: () {},
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
                              color: AppColors.white,
                              size: 25.w,
                            ),
                            AppSpacing.horizontal8,
                            Text(
                              'Download PDF',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.vertical30,
              Text(
                'My Payslips',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              AppSpacing.vertical20,
              ListView.builder(
                itemCount: payrollControllr.payrollList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final data = payrollControllr.payrollList[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 20.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade200,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.dg),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.sp),
                                  color: AppColors.primaryColor,
                                ),
                                child: Icon(
                                  Icons.receipt_long_outlined,
                                  color: AppColors.white,
                                  size: 24,
                                ),
                              ),
                              AppSpacing.horizontal10,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DateFormat(
                                      'yyy-MM-dd',
                                    ).format(data.dateFrom),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  AppSpacing.vertical8,
                                  Text(
                                    'Date From',
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                ],
                              ),
                              AppSpacing.horizontal8,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat(
                                        'yyy-MM-dd',
                                      ).format(data.dateTo),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                    ),
                                    AppSpacing.vertical8,
                                    Text(
                                      'Date To',
                                      style: TextStyle(fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                              ),
                              AppSpacing.horizontal2,
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 8.0.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.sp),
                                  color: payrollControllr.getStatusColor(
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
                          AppSpacing.vertical15,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'SR ${data.payment.toString()}',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 130.w,
                                height: 25.h,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                  ),
                                  child: Text(
                                    'Download PDF',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
