import 'package:get/get.dart';
import 'package:hrm_app/features/attendance/controllers/attendace_controller.dart';
import 'package:hrm_app/features/auth/views/log_in_view.dart';
import 'package:hrm_app/features/auth/views/sign_up_view.dart';
import 'package:hrm_app/features/dashboard/bottom_nav_bar.dart';
import 'package:hrm_app/features/dashboard/bottom_nav_controller.dart';
import 'package:hrm_app/features/employees/controllers/employees_controller.dart';
import 'package:hrm_app/features/employees/views/employee_profile_view.dart';
import 'package:hrm_app/features/expenses/views/edit_expenses_view.dart';
import 'package:hrm_app/features/expenses/views/new_expenses_view.dart';
import 'package:hrm_app/features/expenses/views/expenses_view.dart';
import 'package:hrm_app/features/home/controllers/home_controller.dart';
import 'package:hrm_app/features/home/views/quick_action_view.dart';
import 'package:hrm_app/features/notifications/views/announcement_detail_view.dart';
import 'package:hrm_app/features/notifications/views/announcements_view.dart';
import 'package:hrm_app/features/notifications/views/notifications_view.dart';
import 'package:hrm_app/features/payroll/controllers/payroll_controller.dart';
import 'package:hrm_app/features/payroll/views/payroll_view.dart';
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
import 'package:hrm_app/features/time_off/views/new_request_leave_view.dart';
import 'package:hrm_app/features/time_off/views/team_calendar_view.dart';
import 'package:hrm_app/features/time_off/views/time_off_view.dart';
import 'package:hrm_app/features/time_sheets/views/new_timesheet_view.dart';
import 'package:hrm_app/features/time_sheets/views/timesheet_view.dart';
import 'package:hrm_app/features/time_sheets/views/timesheet_details_view.dart';
import 'package:hrm_app/features/time_sheets/views/edit_timesheet_view.dart';

class AppPages {
  static final page = [
    GetPage(name: '/loginview', page: () => LogInView()),
    GetPage(name: '/signupview', page: () => SignUpView()),
    GetPage(name: '/notification', page: () => NotificationsView()),
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
      }),
    ),
    GetPage(name: '/announcementsview', page: () => AnnouncementsView()),
    GetPage(
      name: '/announcementdetailview',
      page: () => AnnouncementDetailView(),
    ),
    GetPage(name: '/actions', page: () => QuickActionView()),
    GetPage(name: '/employprofile', page: () => EmployProfileView()),
    GetPage(name: '/expenses', page: () => ExpensesView()),
    GetPage(name: '/newexpenses', page: () => NewExpensesView()),
    GetPage(name: '/editexpenses', page: () => EditExpensesView()),
    GetPage(name: '/project', page: () => ProjectsView()),
    GetPage(name: '/task', page: () => TaskView()),
    GetPage(name: '/taskdetail', page: () => TaskDetailsView()),
    GetPage(name: '/timesheet', page: () => TimesheetView()),
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
    GetPage(
      name: '/editquotation',
      page: () => EditQuotationView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => QuotationController());
      }),
    ),
    GetPage(name: '/quotationdetailview', page: () => QuotationDetailView()),
    GetPage(name: '/timeoff', page: () => TimeOffView()),
    GetPage(name: '/newrequest', page: () => NewRequestLeaveView()),
    GetPage(name: '/teamcalender', page: () => TeamCalendarView()),
    GetPage(name: '/myrequests', page: () => MyRequestsView()),
    GetPage(name: '/newrequests', page: () => NewRequestsView()),
    GetPage(name: '/requestdetails', page: () => RequestDetailsView()),
  ];
}
