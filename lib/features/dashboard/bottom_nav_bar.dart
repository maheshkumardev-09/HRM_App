import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/components/custom_nav_bar.dart';
import 'package:hrm_app/features/attendance/views/attendance_view.dart';
import 'package:hrm_app/features/dashboard/bottom_nav_controller.dart';
import 'package:hrm_app/features/employees/views/employees_view.dart';
import 'package:hrm_app/features/home/views/home_view.dart';
import 'package:hrm_app/features/payroll/views/payroll_view.dart';
import 'package:hrm_app/features/sales/views/sales_view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final _controller = Get.find<BottomNavController>();
  final List<Widget?> _cachedViews = List.filled(5, null);
  final List<Widget Function()> viewBuilder = [
    () => HomeView(),
    () => EmployeesView(),
    () => AttendanceView(),
    () => PayrollView(),
    () => SalesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final index = _controller.currentIndex.value;
        _cachedViews[index] ??= viewBuilder[index]();
        return IndexedStack(
          index: index,
          children: List.generate(
            viewBuilder.length,
            (i) => _cachedViews[i] ?? const SizedBox(),
          ),
        );
      }),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
