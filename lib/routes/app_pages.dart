import 'package:get/get.dart';
import 'package:hrm_app/features/attendance/controllers/attendace_controller.dart';
import 'package:hrm_app/features/attendance/views/attendance_view.dart';
import 'package:hrm_app/features/auth/views/log_in_view.dart';
import 'package:hrm_app/features/auth/views/sign_up_view.dart';
import 'package:hrm_app/features/dashboard/bottom_nav_bar.dart';
import 'package:hrm_app/features/dashboard/bottom_nav_controller.dart';
import 'package:hrm_app/features/employees/controllers/employees_controller.dart';
import 'package:hrm_app/features/employees/views/employee_profile_view.dart';
import 'package:hrm_app/features/employees/views/employees_view.dart';
import 'package:hrm_app/features/expenses/controllers/expenses_controller.dart';
import 'package:hrm_app/features/expenses/views/edit_expenses_view.dart';
import 'package:hrm_app/features/expenses/views/new_expenses_view.dart';
import 'package:hrm_app/features/expenses/views/expenses_view.dart';
import 'package:hrm_app/features/home/controllers/home_controller.dart';
import 'package:hrm_app/features/home/views/home_view.dart';
import 'package:hrm_app/features/home/views/quick_action_view.dart';
import 'package:hrm_app/features/payroll/controllers/payroll_controller.dart';
import 'package:hrm_app/features/payroll/views/payroll_view.dart';
import 'package:hrm_app/features/projects/controllers/project_controller.dart';
import 'package:hrm_app/features/projects/controllers/task_controller.dart';
import 'package:hrm_app/features/projects/views/projects_views.dart';
import 'package:hrm_app/features/projects/views/task_details_view.dart';
import 'package:hrm_app/features/projects/views/task_view.dart';
import 'package:hrm_app/features/requests/views/my_requests_view.dart';
import 'package:hrm_app/features/requests/views/request_details_view.dart';
import 'package:hrm_app/features/requests/views/new_requests_view.dart';
import 'package:hrm_app/features/sales/controllers/quotation_controller.dart';
import 'package:hrm_app/features/sales/controllers/sales_controller.dart';
import 'package:hrm_app/features/sales/views/quotation_detail_view.dart';
import 'package:hrm_app/features/sales/views/edit_quotation_view.dart';
import 'package:hrm_app/features/sales/views/new_quotation_view.dart';
import 'package:hrm_app/features/time_off/controllers/time_off_controller.dart';
import 'package:hrm_app/features/time_off/views/new_request_leave_view.dart';
import 'package:hrm_app/features/time_off/views/team_calendar_view.dart';
import 'package:hrm_app/features/time_off/views/time_off_view.dart';
import 'package:hrm_app/features/time_sheets/controllers/time_sheet_controller.dart';
import 'package:hrm_app/features/time_sheets/views/new_timesheet_view.dart';
import 'package:hrm_app/features/time_sheets/views/time_sheet_view.dart';
import 'package:hrm_app/features/time_sheets/views/timesheet_details_view.dart';
import 'package:hrm_app/features/time_sheets/views/edit_timesheet_view.dart';

class AppPages {
  static final page = [
    GetPage(name: '/loginview', page: () => LogInView()),
    GetPage(name: '/signupview', page: () => SignUpView()),
    GetPage(
      name: '/navbar',
      page: () => BottomNavBar(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => BottomNavController());
        Get.lazyPut(() => HomeController());
        Get.lazyPut(() => AttendanceController());
        Get.lazyPut(() => EmployeesController());
        Get.lazyPut(() => PayrollController());
        Get.lazyPut(() => SalesController());
        Get.lazyPut(() => TimeOffController());
      }),
    ),
    GetPage(name: '/home', page: () => HomeView()),
    GetPage(name: '/actions', page: () => QuickActionView()),
    GetPage(name: '/attendance', page: () => AttendanceView()),
    GetPage(name: '/employees', page: () => EmployeesView()),
    GetPage(name: '/employprofile', page: () => EmployProfileView()),
    GetPage(
      name: '/expenses',
      page: () => ExpensesView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ExpensesController());
      }),
    ),
    GetPage(
      name: '/newexpenses',
      page: () => NewExpensesView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ExpensesController());
      }),
    ),
    GetPage(name: '/editexpenses', page: () => EditExpensesView()),
    GetPage(
      name: '/project',
      page: () => ProjectsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ProjectController());
        Get.lazyPut(() => TaskController());
      }),
    ),
    GetPage(
      name: '/task',
      page: () => TaskView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => TaskController());
      }),
    ),
    GetPage(name: '/taskdetail', page: () => TaskDetailsView()),
    GetPage(
      name: '/timesheet',
      page: () => TimeSheetView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => TimeSheetController());
      }),
    ),
    GetPage(name: '/newtimesheet', page: () => NewTimesheetView()),
    GetPage(name: '/timesheetdetail', page: () => TimesheetDetailsView()),
    GetPage(name: '/edittimesheet', page: () => EditTimesheetView()),
    GetPage(name: '/payroll', page: () => PayrollView()),
    GetPage(
      name: '/newquotation',
      page: () => NewQuotationView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => QuotationController());
      }),
    ),
    GetPage(name: '/editquotation', page: () => EditQuotationView()),
    GetPage(name: '/quotationdetailview', page: () => QuotationDetailView()),
    GetPage(
      name: '/timeoff',
      page: () => TimeOffView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => TimeOffController());
      }),
    ),
    GetPage(name: '/newrequest', page: () => NewRequestLeaveView()),
    GetPage(name: '/teamcalender', page: () => TeamCalendarView()),
    GetPage(name: '/myrequests', page: () => MyRequestsView()),
    GetPage(name: '/newrequests', page: () => NewRequestsView()),
    GetPage(name: '/requestdetails', page: () => RequestDetailsView()),
  ];
}
