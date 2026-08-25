import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_button.dart';
import 'package:hrm_app/components/custom_container_with_title.dart';
import 'package:hrm_app/components/custom_dropdown_field.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/projects/controllers/project_controller.dart';
import 'package:hrm_app/features/time_sheets/controllers/timesheet_controller.dart';

class EditTimesheetView extends StatelessWidget {
  EditTimesheetView({super.key});
  final timesheetController = Get.find<TimeSheetController>();
  final projectController = Get.find<ProjectController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
          child: Obx(() {
            final taskNames = timesheetController.selectedProjectTasks
                .map((task) => task.title)
                .toSet()
                .toList();
            return Column(
              children: [
                CustomTitel(title: 'Edit Timesheet'),
                AppSpacing.vertical30,
                CustomContainerWithTitle(
                  titel: 'Date*',
                  widget: CustomTextFiled(
                    readOnly: true,
                    label: '',
                    controller: timesheetController.dateController,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        timesheetController.pickDate(context);
                      },
                      child: Icon(Icons.calendar_today_outlined, size: 24.w),
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
                    items: projectController.projectList
                        .map((project) => project.name)
                        .toList(),
                    onChanged: (value) {
                      timesheetController.selectProject(value!);
                    },
                  ),
                ),
                AppSpacing.vertical20,
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
                  ),
                ),
                AppSpacing.vertical20,
                CustomContainerWithTitle(
                  titel: 'Description',
                  widget: CustomTextFiled(
                    controller: timesheetController.descriptionController,
                    label: '',
                    maxLines: 5,
                  ),
                ),
                AppSpacing.vertical20,
                CustomContainerWithTitle(
                  titel: 'Hours',
                  widget: CustomTextFiled(
                    label: '',
                    controller: timesheetController.hoursController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                AppSpacing.vertical20,
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: CustomButton(
                          title: 'Cancel',
                          titleColor: Colors.black45,
                          onTap: () {
                            Get.back();
                          },
                          buttonColor: Colors.grey.shade300,
                        ),
                      ),
                    ),
                    AppSpacing.horizontal10,
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: CustomButton(
                          title: 'Save Changes',
                          onTap: () {
                            timesheetController.updateTimesheet();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                AppSpacing.vertical30,
              ],
            );
          }),
        ),
      ),
    );
  }
}
