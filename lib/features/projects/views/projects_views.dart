import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_dropdown_field.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/projects/controllers/project_controller.dart';
import 'package:hrm_app/features/projects/controllers/task_controller.dart';
import 'package:hrm_app/routes/app_routes.dart';

class ProjectsView extends StatelessWidget {
  ProjectsView({super.key});
  final projectController = Get.find<ProjectController>();
  final taskController = Get.find<TaskController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          children: [
            CustomTitel(title: 'Projects'),
            AppSpacing.vertical30,
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColors.containerBackColor,
                borderRadius: BorderRadius.circular(25.r),
                border: Border.all(color: AppColors.primaryColor),
              ),
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
                  CustomDropdownField(
                    value: projectController.selectedSort.value,
                    items: ["Name", "Status", "Start Date"],
                    onChanged: (value) {
                      projectController.sortProjects(value!);
                    },
                  ),
                ],
              ),
            ),
            AppSpacing.vertical30,
            Expanded(
              child: Obx(() {
                final projects = projectController.projectList;
                return ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    final data = projects[index];
                    final taskCount = taskController
                        .getTasksByProject(data.id)
                        .length;
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: GestureDetector(
                        onTap: () {
                          taskController.clearAllFilter();
                          Get.toNamed(AppRoutes.taskview, arguments: data.id);
                        },
                        child: Container(
                          padding: EdgeInsets.all(15.w),
                          decoration: BoxDecoration(
                            color: AppColors.containerBackColor,
                            borderRadius: BorderRadius.circular(25.r),
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 50.h,
                                width: 50.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColors.primaryColor,
                                ),
                                child: Image.asset(
                                  'assets/icon/project.png',
                                  width: 24.w,
                                  height: 24.h,
                                ),
                              ),
                              AppSpacing.horizontal15,
                              Expanded(
                                child: Column(
                                  spacing: 5.h,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.name,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      data.description,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
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
                                  '$taskCount Tasks',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
