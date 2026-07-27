import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_action_card.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/home/controllers/home_controller.dart';

class QuickActionView extends StatelessWidget {
  QuickActionView({super.key});
  final home = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showMenu: false),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'More Actions',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(Icons.more_vert),
              ],
            ),
            AppSpacing.vertical20,
            Obx(() {
              final remainingActions = home.quickActions.skip(6).toList();
              return Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12.h,
                    crossAxisSpacing: 12.w,
                  ),

                  itemCount: remainingActions.length,
                  itemBuilder: (context, index) {
                    return CustomActionCard(
                      action: remainingActions[index],
                    ); // sirf 7 wale dikhenge
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
