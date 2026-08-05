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
import 'package:hrm_app/features/time_sheets/controllers/time_sheet_controller.dart';
import 'package:intl/intl.dart';

class EditTimesheetView extends StatelessWidget {
  EditTimesheetView({super.key});
  final timesheetController = Get.find<TimeSheetController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
          child: Obx(
            () => Column(
              children: [
                CustomTitel(title: 'Edit Timesheet', ontap: () {}),
                AppSpacing.vertical30,
                CustomContainerWithTitle(
                  titel: 'Date*',
                  widget: CustomTextFiled(
                    readonly: true,
                    label: '',
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
                      child: CustomButton(
                        title: 'Cancel',
                        titleColor: Colors.black45,
                        onTap: () {
                          Get.back();
                        },
                        buttonColor: Colors.grey.shade300,
                      ),
                    ),
                    AppSpacing.horizontal10,
                    Expanded(
                      child: CustomButton(
                        title: 'Save Changes',
                        onTap: () {
                          timesheetController.updateTimesheet();
                        },
                      ),
                    ),
                  ],
                ),
                AppSpacing.vertical30,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
