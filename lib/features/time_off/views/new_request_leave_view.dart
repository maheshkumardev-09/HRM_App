import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/attachment_upload_box.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_card_tow_title.dart';
import 'package:hrm_app/components/custom_container_with_title.dart';
import 'package:hrm_app/components/custom_dropdown_field.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/time_off/controllers/time_off_controller.dart';

class NewRequestLeaveView extends StatelessWidget {
  NewRequestLeaveView({super.key});
  final timeOffController = Get.find<TimeOffController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTitel(title: 'Request New Leave'),
              AppSpacing.vertical30,
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  color: AppColors.containerBackColor,
                  border: Border.all(color: AppColors.primaryColor),
                ),
                child: Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    color: AppColors.containerBackColordark,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            AppImages.timeicon,
                            width: 50.w,
                            height: 50.h,
                            fit: BoxFit.contain,
                          ),
                          AppSpacing.horizontal15,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Available',
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              AppSpacing.vertical10,
                              Obx(() {
                                final selectedtype =
                                    timeOffController.selectedLeaveType.value;
                                final balance = timeOffController.balanceList
                                    .firstWhereOrNull(
                                      (b) => b.leaveType == selectedtype,
                                    );
                                return Text(
                                  balance != null
                                      ? '${balance.remaining} Days'
                                      : '-- Days',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                      AppSpacing.vertical15,
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 9.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.av_timer, size: 18),
                                Obx(() {
                                  final duration =
                                      (timeOffController.startDate.value !=
                                              null &&
                                          timeOffController.endDate.value !=
                                              null)
                                      ? timeOffController.endDate.value!
                                                .difference(
                                                  timeOffController
                                                      .startDate
                                                      .value!,
                                                )
                                                .inDays +
                                            1
                                      : 0;
                                  return Text(
                                    'Duration: $duration Days',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          AppSpacing.horizontal8,
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 9.w,
                                vertical: 10.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.alarm, size: 18),
                                  Text(
                                    'Holidays Excluded:2 Days',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
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
              ),
              AppSpacing.vertical20,
              CustomContainerWithTitle(
                titel: 'Leave Type*',
                widget: Obx(
                  () => CustomDropdownField(
                    value: timeOffController.selectedLeaveType.value.isEmpty
                        ? null
                        : timeOffController.selectedLeaveType.value,
                    items: timeOffController.balanceList
                        .map((b) => b.leaveType)
                        .toList(),
                    onChanged: (String? value) {
                      timeOffController.selectedLeaveType.value = value!;
                    },
                    hintText: 'Select Leave Type',
                  ),
                ),
              ),
              AppSpacing.vertical15,
              Obx(
                () => Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: AppColors.containerBackColor,
                    borderRadius: BorderRadius.circular(25.r),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: CustomRowCard(
                    title: 'Start Date*',
                    title2: 'End Date*',
                    widget: CustomTextFiled(
                      label: timeOffController.startDate.value == null
                          ? "dd/mm/yyyy"
                          : "${timeOffController.startDate.value!.day}/"
                                "${timeOffController.startDate.value!.month}/"
                                "${timeOffController.startDate.value!.year}",
                      suffixIcon: Icon(
                        Icons.calendar_today_outlined,
                        size: 22.w,
                      ),
                      onTap: () => timeOffController.selectDate(true),
                    ),
                    widget2: CustomTextFiled(
                      label: timeOffController.endDate.value == null
                          ? 'dd/mm/yyyy'
                          : "${timeOffController.endDate.value!.day}/"
                                "${timeOffController.endDate.value!.month}/"
                                "${timeOffController.endDate.value!.year}",
                      suffixIcon: Icon(
                        Icons.calendar_today_outlined,
                        size: 22.w,
                      ),
                      onTap: () => timeOffController.selectDate(false),
                    ),
                  ),
                ),
              ),
              AppSpacing.vertical15,
              CustomContainerWithTitle(
                titel: 'Notes*',
                widget: CustomTextFiled(
                  label: 'add any not or reason of Leave.. ',
                  maxLines: 4,
                  controller: timeOffController.noteController,
                ),
              ),
              AppSpacing.vertical15,
              AttachmentUploadBox(
                title: 'Attachments*',
                onTap: () => timeOffController.pickFile(),
                selectedFile: timeOffController.selectedFile.value,
              ),
              AppSpacing.vertical30,
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: CustomButton(
                        title: 'Cancel',
                        titleColor: Colors.black,
                        onTap: () => Get.back(),
                        buttonColor: Colors.grey.shade300,
                      ),
                    ),
                  ),
                  AppSpacing.horizontal8,
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: CustomButton(
                        title: 'Submit Request',
                        onTap: () {
                          timeOffController.addleave();
                        },
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
  }
}
