import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/policies/policise_controller.dart';

class PoliciesView extends StatelessWidget {
  PoliciesView({super.key});
  final policiesController = Get.find<PoliciesController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
          child: Column(
            children: [
              CustomTitel(title: 'My Policies'),
              AppSpacing.vertical30,
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(color: AppColors.primaryColor),
                  color: AppColors.containerBackColor,
                ),
                child: CustomTextFiled(
                  label: 'Search Policies',
                  prefixIcon: Icon(Icons.search, size: 24.w),
                  fillColor: Colors.grey.shade100,
                  controller: policiesController.searchController,
                  onChanged: (value) {
                    policiesController.updateSearchQuery(value);
                  },
                ),
              ),
              AppSpacing.vertical30,
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: policiesController.filteredPolicies.length,
                itemBuilder: (context, index) {
                  final policy = policiesController.filteredPolicies[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.r),
                        border: Border.all(color: AppColors.borderColor),
                        color: AppColors.containerBackColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 50.h,
                            width: 50.h,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Image.asset('assets/icon/policies_icon.png'),
                          ),
                          AppSpacing.horizontal15,
                          Expanded(
                            child: Column(
                              spacing: 10.h,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  policy.title,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  policy.companyName,
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
                          Obx(() {
                            final isDownloaded = policiesController
                                .pdfDownloaded
                                .contains(policy.pdfUrl);
                            return GestureDetector(
                              onTap: isDownloaded
                                  ? null
                                  : () => policiesController.downloadPdf(
                                      policy.pdfUrl,
                                    ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 8.0.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.r),
                                  color: AppColors.primaryColor,
                                ),
                                child: Text(
                                  isDownloaded ? 'Downloaded' : 'Download PDF',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            );
                          }),
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
