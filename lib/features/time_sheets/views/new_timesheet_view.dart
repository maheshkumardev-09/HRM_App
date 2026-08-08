import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_container_with_title.dart';
import 'package:hrm_app/components/custom_dropdown_field.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/time_sheets/controllers/time_sheet_controller.dart';
import 'package:intl/intl.dart';

class NewTimesheetView extends StatelessWidget {
  NewTimesheetView({super.key});
  final timesheetController = Get.find<TimeSheetController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 15.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitel(title: 'Create New Timesheet', ontap: () {}),
              AppSpacing.vertical30,
              CustomContainerWithTitle(
                titel: 'Date*',
                widget: Obx(
                  () => CustomTextFiled(
                    readOnly: true,
                    label: 'dd/mm/yyyy',
                    controller: TextEditingController(
                      text: timesheetController.selectedDate.value == null
                          ? ""
                          : DateFormat(
                              "dd-MM-yyyy",
                            ).format(timesheetController.selectedDate.value!),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        timesheetController.pickDate(context);
                      },
                      child: Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                ),
              ),
              AppSpacing.vertical20,
              CustomContainerWithTitle(
                titel: 'Project',
                widget: CustomDropdownField(
                  value: timesheetController.selectedProject.value.isEmpty
                      ? null
                      : timesheetController.selectedProject.value,
                  items: timesheetController.projects,
                  onChanged: (value) {
                    timesheetController.selectedProject.value = value!;
                  },
                  hintText: 'Select projects',
                ),
              ),
              AppSpacing.vertical20,
              CustomContainerWithTitle(
                titel: 'Task',
                widget: CustomDropdownField(
                  value: timesheetController.selectedTask.value.isEmpty
                      ? null
                      : timesheetController.selectedTask.value,
                  items: timesheetController.tasks,
                  onChanged: (value) {
                    timesheetController.selectedTask.value = value!;
                  },
                  hintText: 'Select tasks',
                ),
              ),
              AppSpacing.vertical20,
              CustomContainerWithTitle(
                titel: 'Description',
                widget: CustomTextFiled(
                  label: 'Enter description',
                  controller: timesheetController.descriptionController,
                ),
              ),
              AppSpacing.vertical20,
              CustomContainerWithTitle(
                titel: 'Hours',
                widget: CustomTextFiled(
                  keyboardType: TextInputType.number,
                  label: '0.0',
                  controller: timesheetController.hoursController,
                ),
              ),
              AppSpacing.vertical30,
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      titleColor: Colors.black54,
                      title: 'Cancel',
                      buttonColor: Colors.grey.shade300,
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ),
                  AppSpacing.horizontal10,
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        timesheetController.addTimeSheet();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Create Timesheet',
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                        ),
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
