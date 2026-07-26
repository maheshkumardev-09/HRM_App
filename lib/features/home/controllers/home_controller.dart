import 'package:get/get.dart';
import 'package:hrm_app/data/models/announcement_model.dart';
import 'package:hrm_app/data/models/leave_balance_model.dart';
import 'package:hrm_app/data/models/quick_action_model.dart';
import 'package:hrm_app/routes/app_routes.dart';

class HomeController extends GetxController {
  var leaveBalances = <LeaveBalanceModel>[
    LeaveBalanceModel(leaveType: 'Sick Day Off', usedDays: 8, totalDays: 16),
    LeaveBalanceModel(leaveType: 'Paid Leaves', usedDays: 8, totalDays: 16),
    LeaveBalanceModel(leaveType: 'Casual Leave', usedDays: 3, totalDays: 10), //
  ].obs;
  var quickActions = <QuickActionModel>[
    QuickActionModel(
      title: 'Check Out',
      icon: 'assets/icon/icon1.png',
      route: '/attendance',
    ),
    QuickActionModel(
      title: 'Apply Leave',
      icon: 'assets/icon/icon2.png',
      route: AppRoutes.newleaverequestview,
    ),
    QuickActionModel(
      title: 'Submit Expense',
      icon: 'assets/icon/icon3.png',
      route: AppRoutes.newexpensesview,
    ),
    QuickActionModel(
      title: 'New Request',
      icon: 'assets/icon/icon4.png',
      route: '/',
    ),
    QuickActionModel(
      title: 'View Payslip',
      icon: 'assets/icon/icon5.png',
      route: '/payroll',
    ),
    QuickActionModel(
      title: 'My Tasks',
      icon: 'assets/icon/icon6.png',
      route: AppRoutes.taskview,
    ),
    QuickActionModel(
      title: 'Projects',
      icon: 'assets/icon/icon7.png',
      route: AppRoutes.projectview,
    ),
    QuickActionModel(
      title: 'Time off',
      icon: 'assets/icon/icon8.png',
      route: AppRoutes.timeoffview,
    ),
    QuickActionModel(
      title: 'Expenses',
      icon: 'assets/icon/icon3.png',
      route: AppRoutes.expensesview,
    ),
    QuickActionModel(
      title: 'Time Sheets',
      icon: 'assets/icon/icon10.png',
      route: AppRoutes.timesheetview,
    ),
    QuickActionModel(
      title: 'tasks',
      icon: 'assets/icon/icon6.png',
      route: AppRoutes.taskview,
    ),
    QuickActionModel(
      title: 'Weekly Schedule',
      icon: 'assets/icon/icon12.png',
      route: '/survey',
    ),
    QuickActionModel(
      title: 'Requests',
      icon: 'assets/icon/icon4.png',
      route: '/profile',
    ),
    QuickActionModel(
      title: 'Violatioins',
      icon: 'assets/icon/icon14.png',
      route: '/attendance',
    ),
    QuickActionModel(
      title: 'Decisions',
      icon: 'assets/icon/icon15.png',
      route: '/leave/apply',
    ),
    QuickActionModel(
      title: 'CRM',
      icon: 'assets/icon/icon16.png',
      route: '/expense/add',
    ),
    QuickActionModel(
      title: 'Survey',
      icon: 'assets/icon/icon17.png',
      route: '/request/add',
    ),
    QuickActionModel(
      title: 'Policies',
      icon: 'assets/icon/icon18.png',
      route: '/payroll',
    ),
    QuickActionModel(
      title: 'Decumants',
      icon: 'assets/icon/icon19.png',
      route: '/task',
    ),
    QuickActionModel(
      title: 'Addresses',
      icon: 'assets/icon/icon20.png',
      route: '/timesheet',
    ),
    QuickActionModel(
      title: 'Connections & Security',
      icon: 'assets/icon/icon21.png',
      route: '/project',
    ),
    QuickActionModel(
      title: 'My Profile',
      icon: 'assets/icon/icon22.png',
      route: '/sales',
    ),
    QuickActionModel(
      title: 'Logout',
      icon: 'assets/icon/icon23.png',
      route: '/violation',
    ),
  ].obs;
  var announcement = <AnnouncementModel>[
    AnnouncementModel(
      id: '1',
      title: 'Office Closure',
      date: DateTime(2025, 3, 21),
    ),
    AnnouncementModel(
      id: '2',
      title: 'Annual Review Deadline',
      date: DateTime(2025, 3, 21),
    ),
  ].obs;
}
