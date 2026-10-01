import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/crm/controllers/crm_controller.dart';
import 'package:hrm_app/routes/app_routes.dart';

class CRMLeadView extends StatelessWidget {
  CRMLeadView({super.key});
  final crmController = Get.find<CrmController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
          child: Column(
            children: [
              CustomTitel(title: 'My Opporturnitises'),
              AppSpacing.vertical30,
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(color: AppColors.primaryColor),
                  color: AppColors.containerBackColordark,
                ),
                child: Column(
                  spacing: 10.h,
                  children: [
                    Obx(
                      () => Row(
                        spacing: 10.w,
                        children: [
                          Expanded(
                            child: CustomTextFiled(
                              label: crmController.filterDateFrom.value == null
                                  ? 'Date From'
                                  : '${crmController.filterDateFrom.value!.day}/'
                                        '${crmController.filterDateFrom.value!.month}/'
                                        '${crmController.filterDateFrom.value!.year}',
                              suffixIcon: Icon(
                                Icons.calendar_today_outlined,
                                size: 20.w,
                              ),
                              readOnly: true,
                              onTap: () =>
                                  crmController.pickFilterDateFrom(context),
                            ),
                          ),
                          Expanded(
                            child: CustomTextFiled(
                              label: crmController.filterDateTo.value == null
                                  ? 'Date To'
                                  : '${crmController.filterDateTo.value!.day}/'
                                        '${crmController.filterDateTo.value!.month}/'
                                        '${crmController.filterDateTo.value!.year}',
                              suffixIcon: Icon(
                                Icons.calendar_today_outlined,
                                size: 20.w,
                              ),
                              readOnly: true,
                              onTap: () =>
                                  crmController.pickFilterDateTo(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomTextFiled(
                      label: 'Customer Name',
                      controller: crmController.customerFilterController,
                      onChanged: (value) =>
                          crmController.updateCustomerFilter(value),
                    ),
                  ],
                ),
              ),
              AppSpacing.vertical30,
              SizedBox(
                height: 38.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: crmController.stageOptions.length,
                  itemBuilder: (context, index) {
                    return Obx(() {
                      final stage = crmController.stageOptions[index];
                      final isSelected =
                          crmController.selectedStage.value == stage;
                      return Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: GestureDetector(
                          onTap: () => crmController.selectStage(stage),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 5.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.r),
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.textfieldColor,
                            ),
                            child: Center(
                              child: Text(
                                stage,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: isSelected
                                      ? AppColors.whiteColor
                                      : AppColors.textColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
                  },
                ),
              ),
              AppSpacing.vertical20,
              Obx(() {
                if (crmController.leadsList.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        Text('List not found Go beck'),
                        AppSpacing.vertical30,
                        CustomButton(title: 'Go Back', onTap: () => Get.back()),
                      ],
                    ),
                  );
                }
                if (crmController.filteredLeads.isEmpty) {}
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: crmController.filteredLeads.length,
                  itemBuilder: (context, index) {
                    final data = crmController.filteredLeads[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: GestureDetector(
                        onLongPress: () =>
                            crmController.showDeleteDialog(data.id),
                        onTap: () => Get.toNamed(
                          AppRoutes.crmLeaddetailsview,
                          arguments: data.id,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(15.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            border: Border.all(color: AppColors.borderColor),
                            color: AppColors.containerBackColor,
                          ),
                          child: Column(
                            spacing: 10.h,
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
                                    child: Image.asset(
                                      'assets/icon/crm_icon.png',
                                      width: 24.w,
                                      height: 24.h,
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
                                          data.leadName,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'SR ${data.expectedRevenue.toString()}',
                                          style: TextStyle(
                                            fontSize: 12.sp,
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
                                      color: crmController.getStageColor(
                                        data.stage,
                                      ),
                                    ),
                                    child: Text(
                                      data.stage,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      spacing: 5.h,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Customer',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          data.customerName,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      spacing: 5.h,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Email',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          data.email,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  AppSpacing.horizontal30,
                                  Expanded(
                                    child: Column(
                                      spacing: 5.h,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Phone',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          data.phoneNumber,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
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
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 60.w,
        height: 60.h,
        child: FloatingActionButton(
          onPressed: () => Get.toNamed(AppRoutes.addcrmview),
          backgroundColor: AppColors.primaryColor,
          shape: CircleBorder(),
          child: Icon(Icons.add, color: AppColors.whiteColor),
        ),
      ),
    );
  }
}
