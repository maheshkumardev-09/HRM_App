import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/requests/controllers/requests_controller.dart';
import 'package:hrm_app/routes/app_routes.dart';
import 'package:intl/intl.dart';

class RequestsView extends StatelessWidget {
  RequestsView({super.key});
  final requestsController = Get.find<RequestsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 22.w, vertical: 30.h),
        child: Column(
          children: [
            CustomTitel(title: 'My Requests'),
            AppSpacing.vertical30,
            Obx(
              () => Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: AppColors.containerBackColor,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: AppColors.primaryColor),
                ),
                child: Row(
                  spacing: 10.w,
                  children: [
                    Expanded(
                      child: CustomTextFiled(
                        label: requestsController.filterDateFrom.value == null
                            ? 'Date from'
                            : DateFormat('dd-MM-yyyy').format(
                                requestsController.filterDateFrom.value!,
                              ),

                        readOnly: true,
                        onTap: () =>
                            requestsController.pickFilterDateFrom(context),
                        suffixIcon: Icon(
                          Icons.calendar_today_outlined,
                          size: 24.w,
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomTextFiled(
                        label: requestsController.filterDateTo.value == null
                            ? 'Date to'
                            : DateFormat(
                                'dd-MM-yyyy',
                              ).format(requestsController.filterDateTo.value!),
                        readOnly: true,
                        onTap: () =>
                            requestsController.pickFilterDateTo(context),
                        suffixIcon: Icon(
                          Icons.calendar_today_outlined,
                          size: 24.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppSpacing.vertical30,
            Expanded(
              child: Obx(() {
                if (requestsController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                final list = requestsController.filteredRequests;
                if (list.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          'No requests found',
                          style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                        ),
                        AppSpacing.vertical20,
                        SizedBox(
                          height: 48.h,
                          width: 200.w,
                          child: CustomButton(
                            title: 'Clear filter',
                            onTap: () => requestsController.clearDateFilter(),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final data = list[index];
                    return GestureDetector(
                      onTap: () => Get.toNamed(
                        AppRoutes.requestdetailsview,
                        arguments: data,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Container(
                          padding: EdgeInsets.all(15.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.borderColor),
                            borderRadius: BorderRadius.circular(25.r),
                            color: AppColors.containerBackColor,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 50.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.r),
                                      color: AppColors.primaryColor,
                                    ),
                                    child: Icon(
                                      Icons.receipt_long_outlined,
                                      color: AppColors.whiteColor,
                                      size: 25.w,
                                    ),
                                  ),
                                  AppSpacing.horizontal15,
                                  Expanded(
                                    child: Column(
                                      spacing: 10.h,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.requestType,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          data.subject,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
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
                                      borderRadius: BorderRadius.circular(50),
                                      color: requestsController.getStatusColor(
                                        data.status,
                                      ),
                                    ),
                                    child: Text(
                                      data.status,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              AppSpacing.vertical10,
                              Row(
                                spacing: 90.w,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Staet Date',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      AppSpacing.vertical5,
                                      Text(
                                        DateFormat(
                                          'dd-MM-yyyy',
                                        ).format(data.startDate),
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'End Date',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        AppSpacing.vertical5,
                                        Text(
                                          DateFormat(
                                            'dd-MM-yyyy',
                                          ).format(data.endDate),
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
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
        height: 60.h,
        width: 60.w,
        child: FloatingActionButton(
          onPressed: () => Get.toNamed(AppRoutes.newrequestsview),
          shape: const CircleBorder(),
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.add, color: AppColors.whiteColor),
        ),
      ),
    );
  }
}
