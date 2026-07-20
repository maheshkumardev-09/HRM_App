import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/constants/app_colors.dart';
import 'package:hrm_app/features/attendance/views/attendance_view.dart';
import 'package:hrm_app/features/dashboard/bottom_nav_controller.dart';
import 'package:hrm_app/features/employees/views/employees_view.dart';
import 'package:hrm_app/features/home/views/home_view.dart';

class BottomNavBar extends StatelessWidget {
  final navController = Get.put(BottomNavController());
  final List<Widget> viewList = [
    HomeView(),
    EmployeesView(),
    AttendanceView(),
    const Center(child: Text('Requests Screen')),
    const Center(child: Text('Reports Screen')),
  ];

  BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: navController.currentIndex.value,
          children: viewList,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.black,
          onTap: (index) => navController.changeIndex(index),
          currentIndex: navController.currentIndex.value,

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_outlined),
              activeIcon: Icon(Icons.groups),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.edit_calendar),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              activeIcon: Icon(Icons.receipt_long),
              label: '',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined),
              activeIcon: Icon(Icons.bar_chart),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
