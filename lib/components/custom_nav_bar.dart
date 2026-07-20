// import 'package:flutter/material.dart';
// import 'package:hrm_app/constants/app_colors.dart';
// import 'package:hrm_app/features/attendance/views/attendace_view.dart';
// import 'package:hrm_app/features/home/views/home_view.dart';

// class CustomNavBar extends StatefulWidget {
//   const CustomNavBar({super.key});

//   @override
//   State<CustomNavBar> createState() => _CustomNavBarState();
// }

// class _CustomNavBarState extends State<CustomNavBar> {
//   int selectedIndex = 0;

//   final List<Widget> viewList = [
//     HomeView(),
//     AttendaceView(),
//     const Center(child: Text('Team Screen')),
//     const Center(child: Text('Requests Screen')),
//     const Center(child: Text('Reports Screen')),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(index: selectedIndex, children: viewList),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: selectedIndex,
//         selectedItemColor: AppColors.primaryColor,
//         unselectedItemColor: Colors.grey.shade400,
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home)),
//           BottomNavigationBarItem(icon: Icon(Icons.home)),
//           BottomNavigationBarItem(icon: Icon(Icons.home)),
//           BottomNavigationBarItem(icon: Icon(Icons.home)),
//           BottomNavigationBarItem(icon: Icon(Icons.home)),
//         ],
//       ),
//     );
//   }
// }
