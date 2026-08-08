import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_nav_bar.dart';
import 'package:hrm_app/features/attendance/views/attendance_view.dart';
import 'package:hrm_app/features/dashboard/bottom_nav_controller.dart';
import 'package:hrm_app/features/employees/views/employees_view.dart';
import 'package:hrm_app/features/home/views/home_view.dart';
import 'package:hrm_app/features/payroll/views/payroll_view.dart';
import 'package:hrm_app/features/sales/views/sales_view.dart';

class BottomNavBar extends StatelessWidget {
  final bottomNavController = Get.put(BottomNavController());
  final List<Widget> viewList = [
    HomeView(),
    EmployeesView(),
    AttendanceView(),
    PayrollView(),
    SalesView(),
  ];
  BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => viewList[bottomNavController.currentIndex.value]),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
