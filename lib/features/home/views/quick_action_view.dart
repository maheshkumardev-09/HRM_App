import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_action_card.dart';
import 'package:hrm_app/components/custom_app_bar.dart';
import 'package:hrm_app/components/custom_titel.dart';
import 'package:hrm_app/constants/app_spacing.dart';
import 'package:hrm_app/features/home/controllers/home_controller.dart';

class QuickActionView extends StatelessWidget {
  QuickActionView({super.key});
  final home = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final remainingActions = home.quickActions.skip(6).toList();
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
        child: Column(
          children: [
            CustomTitel(title: 'More Actions'),
            AppSpacing.vertical20,
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                  mainAxisExtent: 105.h,
                ),
                itemCount: remainingActions.length,
                itemBuilder: (context, index) {
                  return CustomActionCard(
                    action: remainingActions[index],
                  ); // sirf 7 wale dikhenge
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
