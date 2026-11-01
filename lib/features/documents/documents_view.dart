import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_card_one_title.dart';
import 'package:hrm_app/components/custom_dropdown_field.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/documents/documents_conteroller.dart';
import 'package:intl/intl.dart';

class DocumentsView extends StatelessWidget {
  DocumentsView({super.key});
  final documentsController = Get.find<DocumentsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22..w, vertical: 30.h),
          child: Column(
            children: [
              CustomTitel(title: 'Documents'),
              AppSpacing.vertical30,
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: AppColors.containerBackColordark,
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(color: AppColors.primaryColor),
                ),
                child: Column(
                  spacing: 10.h,
                  children: [
                    Row(
                      spacing: 10.w,
                      children: [
                        Obx(
                          () => Expanded(
                            child: CustomCardOneTitle(
                              titel: 'Grouped by',
                              widget: CustomDropdownField(
                                value:
                                    documentsController.groupedBy.value.isEmpty
                                    ? null
                                    : documentsController.groupedBy.value,
                                hintText: 'Contact',
                                items: documentsController.groupByOptions,
                                onChanged: (value) =>
                                    documentsController.selectGroupedBy(value!),
                              ),
                            ),
                          ),
                        ),
                        Obx(
                          () => Expanded(
                            child: CustomCardOneTitle(
                              titel: 'Filtering Factors',
                              widget: CustomDropdownField(
                                value:
                                    documentsController
                                        .filteringFactor
                                        .value
                                        .isEmpty
                                    ? null
                                    : documentsController.filteringFactor.value,
                                hintText: 'My Documents',
                                items: documentsController.filteringOptions,
                                onChanged: (value) => documentsController
                                    .selectFilteringFactor(value!),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomTextFiled(
                      label: 'Search Document',
                      fillColor: AppColors.textfieldColor,
                      prefixIcon: Icon(Icons.search),
                      controller: documentsController.searchController,
                      onChanged: documentsController.updateSearchQuery,
                    ),
                  ],
                ),
              ),
              AppSpacing.vertical30,
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: documentsController.filteredDocuments.length,
                  itemBuilder: (context, index) {
                    final data = documentsController.filteredDocuments[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Container(
                        padding: EdgeInsets.all(15.w),
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
                              width: 50.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: AppColors.primaryColor,
                              ),
                              child: Image.asset(
                                'assets/icon/documents_icon.png',
                                height: 24.h,
                                width: 24.w,
                              ),
                            ),
                            AppSpacing.horizontal15,
                            Expanded(
                              child: Column(
                                spacing: 8.h,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.name,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    DateFormat(
                                      'MM dd,yyyy',
                                    ).format(data.createdDate),
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => documentsController.downloadDocument(
                                data.id,
                                data.downloadUrl,
                              ),
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
                                  'Download',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
