import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:hrm_app/components/custom_dropdown_field.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/projects/controllers/project_controller.dart';
import 'package:hrm_app/features/time_sheets/controllers/timesheet_controller.dart';
import 'package:hrm_app/routes/app_routes.dart';
import 'package:intl/intl.dart';

class TimesheetView extends StatelessWidget {
  TimesheetView({super.key});
  final timesheetcontroller = Get.find<TimeSheetController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSpacing.vertical30,
              CustomTitel(title: 'My TimeSheets'),
              AppSpacing.vertical30,
              Obx(
                () => Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: AppColors.containerBackColor,
                    borderRadius: BorderRadius.circular(25.r),
                    border: Border.all(color: AppColors.primaryColor),
                  ),
                  child: Column(
                    spacing: 10.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomDropdownField(
                        hintText: 'All Projects',
                        value: timesheetcontroller.filterProject.value.isEmpty
                            ? null
                            : timesheetcontroller.filterProject.value,
                        items: [
                          'All Projects',
                          ...Get.find<ProjectController>().projectList.map(
                            (p) => p.name,
                          ),
                        ],
                        onChanged: (value) {
                          timesheetcontroller.setFilterProject(value!);
                        },
                      ),
                      CustomDropdownField(
                        hintText: 'Task',
                        value: timesheetcontroller.filterTask.value.isEmpty
                            ? null
                            : timesheetcontroller.filterTask.value,
                        items: [
                          'All Tasks',
                          ...timesheetcontroller.filterTaskOptions,
                        ],
                        onChanged: (value) {
                          timesheetcontroller.setFilterTask(value!);
                        },
                      ),
                      Row(
                        spacing: 10.w,
                        children: [
                          Expanded(
                            child: CustomTextFiled(
                              onTap: () => timesheetcontroller
                                  .pickFilterDateFrom(context),
                              readOnly: true,
                              label:
                                  timesheetcontroller.filterDateFrom.value ==
                                      null
                                  ? 'Date From'
                                  : DateFormat('dd/MM/yyyy').format(
                                      timesheetcontroller.filterDateFrom.value!,
                                    ),
                              suffixIcon: Icon(
                                Icons.calendar_today_outlined,
                                size: 24.w,
                              ),
                            ),
                          ),

                          Expanded(
                            child: CustomTextFiled(
                              onTap: () =>
                                  timesheetcontroller.pickFilterDateTo(context),
                              readOnly: true,
                              label:
                                  timesheetcontroller.filterDateTo.value == null
                                  ? 'Date To'
                                  : DateFormat('dd/MM/yyyy').format(
                                      timesheetcontroller.filterDateTo.value!,
                                    ),
                              suffixIcon: Icon(
                                Icons.calendar_today_outlined,
                                size: 24.w,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () => timesheetcontroller.clearFilter(),
                  child: Icon(Icons.remove, size: 24.w),
                ),
              ),
              AppSpacing.vertical20,
              Obx(
                () => ListView.builder(
                  itemCount: timesheetcontroller.filteredTimesheets.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data = timesheetcontroller.filteredTimesheets[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: GestureDetector(
                        onLongPress: () =>
                            timesheetcontroller.showDialog(data.id),
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.timesheetdetailview,
                            arguments: data,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: AppColors.containerBackColor,
                            borderRadius: BorderRadius.circular(25.r),
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 50.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColors.primaryColor,
                                    ),
                                    child: Image.asset(
                                      AppImages.timeShest,
                                      width: 24.w,
                                      height: 24.h,
                                    ),
                                  ),
                                  AppSpacing.horizontal15,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.taskName,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                        AppSpacing.vertical5,
                                        Text(
                                          data.description,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
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
                                    child: Text(
                                      '${data.hoursSpent.toString()} Hours',
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 12.sp,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              AppSpacing.vertical10,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          DateFormat(
                                            'yyyy-MM-dd',
                                          ).format(data.date),
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        AppSpacing.vertical5,
                                        Text(
                                          'Date',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.projectName,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        AppSpacing.vertical5,
                                        Text(
                                          'Project',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      timesheetcontroller.edit(data, index);
                                      Get.toNamed(AppRoutes.edittimesheetview);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                        vertical: 5.h,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: AppColors.primaryColor,
                                      ),
                                      child: Text(
                                        'Edit',
                                        style: TextStyle(
                                          color: AppColors.whiteColor,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
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
                  },
                ),
              ),
              AppSpacing.vertical30,
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 60.w,
        height: 60.h,
        child: FloatingActionButton(
          onPressed: () {
            timesheetcontroller.clearForm();
            Get.toNamed(AppRoutes.newtimesheetview);
          },
          backgroundColor: AppColors.primaryColor,
          shape: const CircleBorder(),
          child: Icon(Icons.add, color: AppColors.whiteColor),
        ),
      ),
    );
  }
}
