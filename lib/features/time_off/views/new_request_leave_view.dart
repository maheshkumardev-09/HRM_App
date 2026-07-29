import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_card_tow_title.dart';
import 'package:hrm_app/components/custom_container_with_title.dart';
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
      appBar: CustomAppBar(showMenu: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTitel(title: 'Request New Leave', ontap: () {}),
              AppSpacing.vertical30,
              Container(
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.grey.shade100,
                  border: Border.all(color: AppColors.primaryColor),
                ),
                child: Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.grey.shade200,
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
                          AppSpacing.horizontal12,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Available',
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              AppSpacing.vertical8,
                              Text(
                                '16 Days',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      AppSpacing.vertical8,
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.av_timer, size: 20),
                                Text(
                                  'Duration:4 Days',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AppSpacing.horizontal2,
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(6.w),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.alarm, size: 20),
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
                  () => DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    hint: Text(
                      "Select Leave Type",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    initialValue:
                        timeOffController.selectedLeaveType.value.isEmpty
                        ? null
                        : timeOffController.selectedLeaveType.value,
                    items: timeOffController.leaveTypes.map((leave) {
                      return DropdownMenuItem(value: leave, child: Text(leave));
                    }).toList(),
                    onChanged: (value) {
                      timeOffController.selectedLeaveType.value = value!;
                    },
                  ),
                ),
              ),
              AppSpacing.vertical20,
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: CustomRowCard(
                  title: 'Start Date*',
                  title2: 'End Date*',
                  widget: Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Text(
                            timeOffController.startDate.value == null
                                ? "dd/mm/yyyy"
                                : "${timeOffController.startDate.value!.day}/"
                                      "${timeOffController.startDate.value!.month}/"
                                      "${timeOffController.startDate.value!.year}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            timeOffController.selectDate(true);
                          },
                          child: Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  widget2: Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          timeOffController.endDate.value == null
                              ? 'dd/mm/yyyy'
                              : "${timeOffController.endDate.value!.day}/"
                                    "${timeOffController.endDate.value!.month}/"
                                    "${timeOffController.endDate.value!.year}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => timeOffController.selectDate(false),
                          child: Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AppSpacing.vertical20,
              CustomContainerWithTitle(
                titel: 'Notes*',
                widget: TextField(
                  controller: timeOffController.noteController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    hint: Text('add any not or reason of Leave.. '),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  maxLines: 4,
                ),
              ),
              AppSpacing.vertical20,
              CustomContainerWithTitle(
                titel: 'Attachments*',
                widget: GestureDetector(
                  onTap: () {
                    timeOffController.pickFile();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.grey.shade100,
                    ),
                    child: Obx(
                      () => timeOffController.selectedFile.value == null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.green.shade100,
                                  ),
                                  child: Icon(
                                    Icons.file_upload_outlined,
                                    color: AppColors.primaryColor,
                                    size: 24.w,
                                  ),
                                ),
                                Text(
                                  'Drop file here and cilck to upload',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black45,
                                  ),
                                ),
                                AppSpacing.vertical8,
                                Text(
                                  'PDF,PNG,JPG up to 10MB',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              timeOffController.selectedFile.value!.path
                                  .split("/")
                                  .last,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              AppSpacing.vertical30,
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      title: 'Cancel',
                      titleColor: Colors.black,
                      onTap: () => Get.back(),
                      buttonColor: Colors.grey.shade300,
                    ),
                  ),
                  AppSpacing.horizontal8,
                  Expanded(
                    child: CustomButton(
                      title: 'SubmitRequest',
                      onTap: () {
                        timeOffController.addleave();
                      },
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
