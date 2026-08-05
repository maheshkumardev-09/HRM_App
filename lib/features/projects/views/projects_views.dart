import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_2.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/projects/controllers/project_controller.dart';
import 'package:hrm_app/features/projects/controllers/task_controller.dart';
import 'package:hrm_app/routes/app_routes.dart';

class ProjectsView extends StatelessWidget {
  ProjectsView({super.key});
  final sortController = TextEditingController();
  final projectController = Get.find<ProjectController>();
  final taskController = Get.find<TaskController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            CustomTitel(title: 'Projects', ontap: () {}),
            AppSpacing.vertical20,
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade400),
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
                  Custom2(
                    titel: 'Name',
                    icon: Icons.keyboard_arrow_down,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            AppSpacing.vertical20,
            Expanded(
              child: ListView.builder(
                itemCount: projectController.projectList.length,

                itemBuilder: (context, index) {
                  final data = projectController.projectList[index];
                  return Obx(() {
                    final taskCount = taskController
                        .getTasksByProject(data.id)
                        .length;
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.taskview, arguments: data.id);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 40.h,
                                width: 50.w,
                                margin: EdgeInsets.only(top: 8.h),
                                padding: EdgeInsets.all(5.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.primaryColor,
                                ),
                                child: Icon(
                                  Icons.business_center_outlined,
                                  size: 20.w,
                                  color: AppColors.white,
                                ),
                              ),
                              AppSpacing.horizontal10,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.name,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    AppSpacing.horizontal10,
                                    Text(
                                      data.description,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8.h),
                                padding: EdgeInsets.all(5.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
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
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
