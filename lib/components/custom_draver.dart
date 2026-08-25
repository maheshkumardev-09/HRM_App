import 'package:flutter/material.dart';
import 'package:hrm_app/constants/app_colors.dart';

class CustomDraver extends StatelessWidget {
  const CustomDraver({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.containerBackColor,
      child: SafeArea(child: ListView(children: [])),
    );
  }
}
