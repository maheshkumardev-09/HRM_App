import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
  final searchControlle = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final String? projectId = Get.arguments;

    return Scaffold(
      appBar: CustomAppBar(showMenu: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTitel(title: 'Tasks', ontap: () {}),
              AppSpacing.vertical20,
              Container(
                padding: EdgeInsets.all(8.w),
                // height: 90.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Image.asset(
                        'assets/icon/icon6.png',
                        width: 50.w,
                        height: 50.h,
                      ),
                      title: Text(
                        'Total Tasks',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Text(
                        '07',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    AppSpacing.vertical10,
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
                              Container(
                                padding: EdgeInsets.all(8.w),
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Newest',
                                      style: TextStyle(fontSize: 12.sp),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Icon(Icons.keyboard_arrow_down),
                                    ),
                                  ],
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
                                'Group Bay',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              AppSpacing.vertical10,
                              Container(
                                padding: EdgeInsets.all(8.w),
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Stage',
                                      style: TextStyle(fontSize: 12.sp),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Icon(Icons.keyboard_arrow_down),
                                    ),
                                  ],
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
                      controller: searchControlle,
                      prefixicon: Icon(Icons.search),
                    ),
                  ],
                ),
              ),
              AppSpacing.vertical20,
              Obx(() {
                final filteredTasks = projectId != null
                    ? taskController.getTasksByProject(projectId)
                    : taskController.taskList;

                if (filteredTasks.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 100.h),
                      child: Column(
                        children: [
                          Icon(
                            Icons.task_outlined,
                            size: 60.sp,
                            color: Colors.grey.shade400,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'No tasks found for this project',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    final data = filteredTasks[index];
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
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColors.primaryColor,
                                    ),
                                    width: 50.w,
                                    height: 40.h,
                                    child: Icon(
                                      Icons.calendar_month_outlined,
                                      size: 24.w,
                                      color: AppColors.white,
                                    ),
                                  ),
                                  AppSpacing.horizontal10,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '#00${data.id}',
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
                                        AppSpacing.vertical8,
                                        Text(
                                          data.title,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 8.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
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
                                      AppSpacing.vertical8,
                                      Text(
                                        data.assignee,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Total Time',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        AppSpacing.vertical8,
                                        Text(
                                          data.totalTime,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Time Spent',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      AppSpacing.vertical8,
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
            ],
          ),
        ),
      ),
    );
  }
}
