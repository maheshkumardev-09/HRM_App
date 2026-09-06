import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/requests/controllers/requests_controller.dart';

class NewRequestView extends StatelessWidget {
  NewRequestView({super.key});
  final requestsController = Get.find<RequestsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 22.w, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitel(title: 'Select Request Type'),
            AppSpacing.vertical15,
            Text('Click on button to create a new request'),
            AppSpacing.vertical30,
            CustomTextFiled(
              label: 'Search',
              showBorder: false,
              prefixIcon: Icon(Icons.search),
              fillColor: AppColors.textfieldColor,
              controller: requestsController.searchController,
              onChanged: (value) {
                requestsController.updateSearch(value);
              },
            ),
            AppSpacing.vertical20,
            Expanded(
              child: Obx(() {
                final types = requestsController.filteredRequestTypes;
                if (types.isEmpty) {
                  return Center(
                    child: Text(
                      'No request type found',
                      style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    ),
                  );
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    mainAxisExtent: 135.h,
                  ),
                  itemCount: types.length,
                  itemBuilder: (context, index) {
                    final type = types[index];
                    return GestureDetector(
                      onTap: () {
                        requestsController.selectedRequestType.value =
                            type.title;
                        Get.toNamed(type.route);
                      },
                      child: Container(
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                          color: AppColors.containerBackColor,
                          border: Border.all(color: AppColors.borderColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              child: Image.asset(
                                type.icon,
                                width: 24.w,
                                height: 24.h,
                                color: AppColors.whiteColor,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              type.title,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
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
    );
  }
}
