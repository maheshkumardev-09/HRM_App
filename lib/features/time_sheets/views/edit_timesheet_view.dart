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
import 'package:hrm_app/features/time_sheets/models/time_sheet_model.dart';
import 'package:intl/intl.dart';

class EditTimesheetView extends StatefulWidget {
  EditTimesheetView({super.key});

  @override
  State<EditTimesheetView> createState() => _EditTimesheetViewState();
}

class _EditTimesheetViewState extends State<EditTimesheetView> {
  final timesheetController = Get.find<TimeSheetController>();
  late TimesheetModel timesheet;
  late int index;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    timesheet = args["data"];
    index = args["index"];

    timesheetController.descriptionController.text = timesheet.description;
    timesheetController.hoursController.text = timesheet.hoursSpent.toString();
    timesheetController.selectedProject.value = timesheet.projectName;
    timesheetController.selectedTask.value = timesheet.taskTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showMenu: false),
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
                    label: timesheet.date,
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
                    hintText: timesheet.projectName,
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
                    hintText: timesheet.taskTitle,
                  ),
                ),
                AppSpacing.vertical20,
                CustomContainerWithTitle(
                  titel: 'Description',
                  widget: CustomTextFiled(
                    controller: timesheetController.descriptionController,
                    label: "Enter Description",
                    maxLines: 5,
                  ),
                ),
                AppSpacing.vertical20,
                CustomContainerWithTitle(
                  titel: 'Hours',
                  widget: CustomTextFiled(
                    label: timesheet.hoursSpent.toString(),
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
                          TimesheetModel updatedData = TimesheetModel(
                            date: timesheet.date,
                            employeeName: timesheet.employeeName,
                            description:
                                timesheetController.descriptionController.text,
                            hoursSpent:
                                double.tryParse(
                                  timesheetController.hoursController.text,
                                ) ??
                                0,
                            taskId: timesheet.taskId,
                            taskTitle:
                                timesheetController.selectedTask.value.isEmpty
                                ? timesheet.taskTitle
                                : timesheetController.selectedTask.value,
                            projectName:
                                timesheetController
                                    .selectedProject
                                    .value
                                    .isEmpty
                                ? timesheet.projectName
                                : timesheetController.selectedProject.value,
                          );
                          timesheetController.updateTimeSheet(
                            index,
                            updatedData,
                          );
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
