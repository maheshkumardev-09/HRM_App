import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_card_one_title.dart';
import 'package:hrm_app/components/custom_dropdown_field.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/decisions/controllers/decisions_controller.dart';
import 'package:hrm_app/routes/app_routes.dart';
import 'package:intl/intl.dart';

class DecisionsView extends StatelessWidget {
  DecisionsView({super.key});
  final decisionController = Get.find<DecisionsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
          child: Column(
            children: [
              CustomTitel(title: 'My Decisions'),
              AppSpacing.vertical30,
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(color: AppColors.primaryColor),
                  color: AppColors.containerBackColor,
                ),
                child: Row(
                  spacing: 10.w,
                  children: [
                    Expanded(
                      child: CustomCardOneTitle(
                        titel: 'Sort by',
                        widget: Obx(
                          () => CustomDropdownField(
                            value: decisionController.selectedSort.value,
                            items: decisionController.sortOptions,
                            onChanged: (value) =>
                                decisionController.selectSort(value!),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomCardOneTitle(
                        titel: 'Filter by',
                        widget: Obx(
                          () => CustomDropdownField(
                            value: decisionController.selectedFilter.value,
                            items: decisionController.filterOptions,
                            onChanged: (value) =>
                                decisionController.selectFilter(value!),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.vertical30,
              Obx(() {
                if (decisionController.filteredDecisions.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          "No decisions found for this filter",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                        AppSpacing.vertical15,
                        SizedBox(
                          height: 40.h,
                          width: 130.w,
                          child: CustomButton(
                            title: 'Clear Filter',
                            onTap: () => decisionController.resetAll(),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: decisionController.filteredDecisions.length,
                  itemBuilder: (context, index) {
                    final data = decisionController.filteredDecisions[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: GestureDetector(
                        onTap: () => Get.toNamed(
                          AppRoutes.decisiondetailsview,
                          arguments: data.id,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(15.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            border: Border.all(color: AppColors.borderColor),
                            color: AppColors.containerBackColor,
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 50.h,
                                width: 50.w,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: Image.asset(
                                  'assets/icon/decision_icon.png',
                                  width: 24.w,
                                  height: 24.h,
                                ),
                              ),
                              AppSpacing.horizontal15,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 10.h,
                                children: [
                                  Text(
                                    'DEC#${data.id}',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    data.title,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              AppSpacing.horizontal30,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10.h,
                                  children: [
                                    Text(
                                      'Date',
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      DateFormat(
                                        'yyyy-MM-dd',
                                      ).format(data.date),
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
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
                                  color: decisionController.getStatusColor(
                                    data.status,
                                  ),
                                ),
                                child: Text(
                                  data.status,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
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
    );
  }
}
