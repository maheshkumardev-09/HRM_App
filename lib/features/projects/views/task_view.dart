import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_dropdown_field.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/projects/controllers/task_controller.dart';
import 'package:hrm_app/routes/app_routes.dart';

class TaskView extends StatelessWidget {
  TaskView({super.key});
  final taskController = Get.find<TaskController>();
  @override
  Widget build(BuildContext context) {
    final String? projectId = Get.arguments is String
        ? Get.arguments as String
        : null;

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSpacing.vertical30,
              CustomTitel(title: 'Tasks'),
              AppSpacing.vertical30,
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: AppColors.containerBackColor,
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(color: AppColors.primaryColor),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/icon/icon6.png',
                          width: 50.w,
                          height: 50.h,
                        ),
                        AppSpacing.horizontal10,
                        Expanded(
                          child: Text(
                            'Total Tasks',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Obx(
                          () => Text(
                            taskController
                                .getTasks(projectId: projectId)
                                .toList()
                                .length
                                .toString(),
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.vertical15,
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sort By',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              AppSpacing.vertical10,
                              Obx(
                                () => CustomDropdownField(
                                  value: taskController.sortBy.value,
                                  items: [
                                    'Newest',
                                    'Oldest',
                                    'Priority',
                                    'Progress',
                                  ],
                                  onChanged: (value) {
                                    if (value != null) {
                                      taskController.setSortBy(value);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppSpacing.horizontal8,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Group By',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              AppSpacing.vertical10,
                              Obx(
                                () => CustomDropdownField(
                                  value: taskController.groupBy.value,
                                  items: [
                                    'Stage',
                                    'Assignee',
                                    'Priority',
                                    'None',
                                  ],
                                  onChanged: (value) {
                                    if (value != null) {
                                      taskController.setGroupBy(value);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.vertical15,

                    CustomTextFiled(
                      label: 'Search',
                      controller: taskController.searchController,
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          taskController.clearAllFilter();
                        },
                        child: Icon(Icons.remove),
                      ),
                      fillColor: AppColors.textfieldColor,
                      showBorder: false,
                      onChanged: (value) {
                        taskController.updateSearch(value);
                      },
                    ),
                  ],
                ),
              ),
              AppSpacing.vertical30,
              Obx(() {
                final tasks = taskController.getTasks(projectId: projectId);
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final data = tasks[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.taskdetailview,
                          arguments: data.id,
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Container(
                          padding: EdgeInsets.all(15.w),
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
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColors.primaryColor,
                                    ),
                                    width: 50.w,
                                    height: 50.h,
                                    child: Icon(
                                      Icons.calendar_month_outlined,
                                      size: 24.w,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                  AppSpacing.horizontal15,
                                  Expanded(
                                    child: Column(
                                      spacing: 15.h,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '#${data.id}',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            AppSpacing.horizontal2,
                                            Row(
                                              children: List.generate(
                                                data.priority,
                                                (index) => Container(
                                                  margin: EdgeInsets.only(
                                                    right: 4,
                                                  ),
                                                  height: 6,
                                                  width: 6,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColors.primaryColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          data.title,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    child: Text(
                                      data.taskType,
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              AppSpacing.vertical10,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    spacing: 5.h,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Assignees',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),

                                      Text(
                                        data.assignee,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 5.h,
                                    children: [
                                      Text(
                                        'Total Time',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        data.totalTime,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 5.h,
                                    children: [
                                      Text(
                                        'Time Spent',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        data.timeSpent,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
              AppSpacing.vertical20,
            ],
          ),
        ),
      ),
    );
  }
}
