import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_text_filed.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/projects/controllers/project_controller.dart';
import 'package:hrm_app/features/projects/controllers/task_controller.dart';
import 'package:hrm_app/features/time_sheets/controllers/timesheet_controller.dart';
import 'package:intl/intl.dart';

class TaskDetailsView extends StatelessWidget {
  TaskDetailsView({super.key});
  final taskController = Get.find<TaskController>();
  final projectController = Get.find<ProjectController>();
  final timesheetController = Get.find<TimeSheetController>();

  @override
  Widget build(BuildContext context) {
    final String taskId = Get.arguments;
    final task = taskController.getTaskById(taskId);
    if (task == null) {
      return const Scaffold(body: Center(child: Text('Task not found')));
    }
    final project = projectController.getProjectById(task.projectId);
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacing.vertical30,
              Row(
                children: [
                  Text(
                    '(#${task.id})',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AppSpacing.horizontal2,
                  Row(
                    children: List.generate(
                      task.priority,
                      (index) => Container(
                        margin: EdgeInsets.only(right: 4),
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              AppSpacing.vertical10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AppSpacing.vertical15,
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: AppColors.primaryColor),
                    ),
                    child: Text(
                      task.taskType,
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                  AppSpacing.vertical15,
                  Text(
                    'Project',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  AppSpacing.vertical10,
                  Text(
                    project?.name ?? '',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.vertical15,
                  Text(
                    'Deadline',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  AppSpacing.vertical10,
                  Text(
                    task.deadline,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.vertical15,
                  Text(
                    'Allocated Time',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  AppSpacing.vertical10,
                  Text(
                    task.totalTime,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.vertical15,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        '${(task.progress).toInt()}%'.toString(),
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.vertical10,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: LinearProgressIndicator(
                      value: task.progress / 100,
                      minHeight: 8.h,
                      backgroundColor: Colors.grey.shade300,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              AppSpacing.vertical30,
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: AppColors.containerBackColordark,
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(color: AppColors.primaryColor),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.personIcon,
                      width: 50.w,
                      height: 50.h,
                    ),
                    AppSpacing.horizontal15,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Assignees: ${task.assignee}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        AppSpacing.vertical15,
                        Row(
                          children: [
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
                                task.phone,
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 10.sp,
                                ),
                                maxLines: 1,
                              ),
                            ),
                            AppSpacing.horizontal8,
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
                                task.email,
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 10.sp,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppSpacing.vertical30,
              Text(
                'Description',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              AppSpacing.vertical20,
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  color: AppColors.containerBackColor,
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: task.description.map((line) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Text('•  $line'),
                    );
                  }).toList(),
                ),
              ),
              AppSpacing.vertical30,
              Text(
                'TimeShetes',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              AppSpacing.vertical20,
              Obx(() {
                final entries = timesheetController.getEntriesByTask(task.id);
                if (entries.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Center(
                      child: Text(
                        'No timesheet entries for this task',
                        style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final data = entries[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Container(
                        padding: EdgeInsets.all(15.w),
                        decoration: BoxDecoration(
                          color: AppColors.containerBackColor,
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(color: AppColors.borderColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat(
                                        'dd-MM-yyyy',
                                      ).format(data.date),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    AppSpacing.vertical8,
                                    Text(
                                      'Date',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        data.employeeName,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      AppSpacing.vertical8,
                                      Text(
                                        'Employee',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsetsDirectional.symmetric(
                                    vertical: 6,
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(15.r),
                                    border: Border.all(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  child: Text(
                                    '${data.hoursSpent} Hours',
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            AppSpacing.vertical10,
                            Text(
                              data.description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
              AppSpacing.vertical30,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Time Spent',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    '${task.timeSpent} Hours',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              AppSpacing.vertical20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Time Remaing',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    '${task.timeRemaining} Hours',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              AppSpacing.vertical30,
              Divider(thickness: 2, color: Colors.grey.shade300),
              AppSpacing.vertical20,
              Text(
                'Communication History',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              AppSpacing.vertical20,
              Row(
                children: [
                  Expanded(
                    child: CustomTextFiled(
                      label: 'Write Message..',
                      controller: taskController.messageController,
                    ),
                  ),
                  AppSpacing.horizontal8,
                  GestureDetector(
                    onTap: () {
                      taskController.sendMessage(
                        task.id,
                        taskController.messageController.text,
                      );
                      taskController.messageController.clear();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.primaryColor,
                      ),
                      child: Icon(
                        Icons.send,
                        color: AppColors.whiteColor,
                        size: 24.w,
                      ),
                    ),
                  ),
                ],
              ),
              AppSpacing.vertical20,
              Row(
                children: [
                  Text(
                    'Apr 28, 2026',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  ),
                  AppSpacing.horizontal10,
                  Expanded(
                    child: Divider(thickness: 2, color: Colors.grey.shade300),
                  ),
                ],
              ),
              AppSpacing.vertical30,
              Obx(() {
                final currentTask = taskController.getTaskById(task.id);
                if (currentTask == null) return const SizedBox();
                return Column(
                  children: currentTask.messages.map((msg) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            AppImages.personIcon,
                            width: 30.w,
                            height: 30.w,
                          ),
                          AppSpacing.horizontal10,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      msg.senderName,
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    AppSpacing.horizontal8,
                                    Text(
                                      msg.sentAt,
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                AppSpacing.vertical8,
                                Container(
                                  padding: EdgeInsets.all(10.w),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Text(
                                    msg.message,
                                    style: TextStyle(fontSize: 13.sp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
