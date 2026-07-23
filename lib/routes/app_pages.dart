import 'package:get/get.dart';
import 'package:hrm_app/features/attendance/views/attendance_view.dart';
import 'package:hrm_app/features/auth/views/log_in_view.dart';
import 'package:hrm_app/features/auth/views/sign_up_view.dart';
import 'package:hrm_app/features/auth/views/splash_view.dart';
import 'package:hrm_app/features/dashboard/bottom_nav_bar.dart';
import 'package:hrm_app/features/employees/views/employee_profile_view.dart';
import 'package:hrm_app/features/employees/views/employees_view.dart';
import 'package:hrm_app/features/expenses/views/add_expenses_view.dart';
import 'package:hrm_app/features/expenses/views/expenses_view.dart';
import 'package:hrm_app/features/home/views/home_view.dart';
import 'package:hrm_app/features/home/views/quick_action_view.dart';
import 'package:hrm_app/features/projects/views/projects_views.dart';
import 'package:hrm_app/features/projects/views/task_details_view.dart';
import 'package:hrm_app/features/projects/views/task_view.dart';
import 'package:hrm_app/features/time_sheets/views/time_sheet_view.dart';

class AppPages {
  static final page = [
    GetPage(name: '/splashview', page: () => SplashView()),
    GetPage(name: '/loginview', page: () => LogInView()),
    GetPage(name: '/signupview', page: () => SignUpView()),
    GetPage(name: '/navbar', page: () => BottomNavBar()),
    GetPage(name: '/homeview', page: () => HomeView()),
    GetPage(name: '/actions', page: () => QuickActionView()),
    GetPage(name: '/attendance', page: () => AttendanceView()),
    GetPage(name: '/empolyees', page: () => EmployeesView()),
    GetPage(name: '/empolyeesprofile', page: () => EmployProfileView()),
    GetPage(name: '/expanses', page: () => ExpensesView()),
    GetPage(name: '/addexpenses', page: () => AddExpensesView()),
    GetPage(name: '/project', page: () => ProjectsView()),
    GetPage(name: '/task', page: () => TaskView()),
    GetPage(name: '/taskdetail', page: () => TaskDetailsView()),
    GetPage(name: '/timesheet', page: () => TimeSheetView()),
  ];
}
