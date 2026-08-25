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
import 'package:hrm_app/features/projects/controllers/project_controller.dart';
import 'package:hrm_app/features/time_sheets/controllers/timesheet_controller.dart';

class NewTimesheetView extends StatelessWidget {
  NewTimesheetView({super.key});
  final timesheetController = Get.find<TimeSheetController>();
  final projectController = Get.find<ProjectController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 22.w, vertical: 30.h),
        child: Obx(() {
          final taskNames = timesheetController.selectedProjectTasks
              .map((task) => task.title)
              .toSet()
              .toList();
          return SingleChildScrollView(
            child: Column(
              spacing: 15.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTitel(title: 'Create New Timesheet'),
                AppSpacing.vertical15,
                CustomContainerWithTitle(
                  titel: 'Date*',
                  widget: CustomTextFiled(
                    controller: timesheetController.dateController,
                    readOnly: true,
                    label: 'dd/mm/yyyy',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        timesheetController.pickDate(context);
                      },
                      child: Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                ),
                CustomContainerWithTitle(
                  titel: 'Project',
                  widget: CustomDropdownField(
                    value: timesheetController.selectedProject.value.isEmpty
                        ? null
                        : timesheetController.selectedProject.value,
                    items: projectController.projectList
                        .map((projrct) => projrct.name)
                        .toList(),
                    onChanged: (value) {
                      timesheetController.selectProject(value!);
                    },
                    hintText: 'Select projects',
                  ),
                ),
                CustomContainerWithTitle(
                  titel: 'Task',
                  widget: CustomDropdownField(
                    value: timesheetController.selectedTask.value.isEmpty
                        ? null
                        : timesheetController.selectedTask.value,
                    items: taskNames,
                    onChanged: (value) {
                      timesheetController.selectedTask.value = value!;
                    },
                    hintText: 'Select tasks',
                  ),
                ),
                CustomContainerWithTitle(
                  titel: 'Description',
                  widget: CustomTextFiled(
                    label: 'Enter description',
                    controller: timesheetController.descriptionController,
                  ),
                ),
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
                      child: SizedBox(
                        height: 48.h,
                        child: CustomButton(
                          titleColor: Colors.black54,
                          title: 'Cancel',
                          buttonColor: Colors.grey.shade300,
                          onTap: () {
                            Get.back();
                          },
                        ),
                      ),
                    ),
                    AppSpacing.horizontal10,
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
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
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
