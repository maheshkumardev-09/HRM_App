import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/crm/controllers/crm_controller.dart';
import 'package:hrm_app/routes/app_routes.dart';
import 'package:intl/intl.dart';

class CrmLeadDetailsView extends StatelessWidget {
  CrmLeadDetailsView({super.key});
  final crmController = Get.find<CrmController>();

  @override
  Widget build(BuildContext context) {
    final String getId = Get.arguments;
    final data = crmController.getLeadById(getId);
    if (data == null) {
      return Scaffold(
        appBar: CustomAppBar(),
        body: Column(
          children: [
            Text('Not found data'),
            AppSpacing.vertical15,
            CustomButton(
              title: 'Go Back',
              onTap: () {
                Get.back();
              },
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
          child: Obx(() {
            final data = crmController.getLeadById(getId);
            if (data == null) return SizedBox();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10.h,
                      children: [
                        Text(
                          '(#00${data.id})',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          data.leadName,
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(
                        AppRoutes.editcrmleadview,
                        arguments: data.id,
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
                        child: Row(
                          spacing: 5.w,
                          children: [
                            Icon(
                              Icons.edit_outlined,
                              size: 20.w,
                              color: AppColors.whiteColor,
                            ),
                            Text(
                              'Edit',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                AppSpacing.vertical15,
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    color: crmController.getStageColor(data.stage),
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
                AppSpacing.vertical15,
                Text(
                  'Revenue',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                AppSpacing.vertical10,
                Text(
                  'SR ${data.expectedRevenue.toString()}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppSpacing.vertical30,
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    border: Border.all(color: AppColors.primaryColor),
                    color: AppColors.containerBackColordark,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        AppImages.personIcon,
                        width: 50.w,
                        height: 50.h,
                      ),
                      AppSpacing.horizontal15,
                      Expanded(
                        child: Column(
                          spacing: 15.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Customer: ',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: data.customerName,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              spacing: 10.w,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 5.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.r),
                                      border: Border.all(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    child: Row(
                                      spacing: 5.w,
                                      children: [
                                        Icon(
                                          Icons.phone_outlined,
                                          size: 13.w,
                                          color: AppColors.primaryColor,
                                        ),
                                        Expanded(
                                          child: Text(
                                            data.phoneNumber,
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryColor,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 5.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.r),
                                      border: Border.all(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    child: Row(
                                      spacing: 5.w,
                                      children: [
                                        Icon(
                                          Icons.email_outlined,
                                          size: 13.w,
                                          color: AppColors.primaryColor,
                                        ),
                                        Expanded(
                                          child: Text(
                                            data.email,
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryColor,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
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
                AppSpacing.vertical30,
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppSpacing.vertical15,
                Container(
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    border: Border.all(color: AppColors.borderColor),
                    color: AppColors.textfieldColor,
                  ),
                  child: Column(
                    children: data.description
                        .split('\n') // string ko lines mein todo
                        .where(
                          (line) => line.trim().isNotEmpty,
                        ) // khaali lines hataao
                        .map(
                          (line) => Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('•  ', style: TextStyle(fontSize: 13.sp)),
                                Expanded(
                                  child: Text(
                                    line.trim(),
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                AppSpacing.vertical30,
                Divider(color: AppColors.textfieldColor, thickness: 2),
                AppSpacing.vertical30,
                Text(
                  'History',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppSpacing.vertical20,
                Row(
                  spacing: 10.w,
                  children: [
                    Expanded(
                      child: CustomTextFiled(
                        label: 'Log on internal note...',
                        controller: crmController.noteController,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => crmController.addNote(data.id),
                      child: Container(
                        height: 48.h,
                        width: 48.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: AppColors.primaryColor,
                        ),
                        child: Image.asset('assets/icon/send_icon.png'),
                      ),
                    ),
                  ],
                ),
                AppSpacing.vertical20,
                if (data.history.isEmpty)
                  Text(
                    'No notes yet',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textColor,
                    ),
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 10.w,
                        children: [
                          Text(
                            DateFormat(
                              'MMM dd, yyyy',
                            ).format(data.history.last.date),
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: AppColors.textfieldColor,
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),
                      AppSpacing.vertical20,
                      ...data.history.map((note) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                spacing: 10.w,
                                children: [
                                  CircleAvatar(
                                    radius: 25.r,
                                    backgroundColor:
                                        AppColors.containerBackColordark,
                                    child: Image.asset(
                                      AppImages.personIcon,
                                      width: 30.w,
                                      height: 30.h,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      note.authorName,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    DateFormat(
                                      'yyyy-MM-dd hh:mm:ss',
                                    ).format(note.date),
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: AppColors.textColor,
                                    ),
                                  ),
                                ],
                              ),
                              AppSpacing.vertical10,
                              Container(
                                padding: EdgeInsets.all(10.w),
                                margin: EdgeInsets.only(left: 40.w),
                                decoration: BoxDecoration(
                                  color: AppColors.containerBackColordark,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15.r),
                                    bottomLeft: Radius.circular(15.r),
                                    bottomRight: Radius.circular(15.r),
                                  ),
                                ),
                                child: Text(
                                  note.note,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
