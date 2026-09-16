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
import 'package:hrm_app/features/requests/views/apply_for_another_view.dart';
import 'package:hrm_app/features/requests/views/benefit_disbursement_view.dart';
import 'package:hrm_app/features/requests/views/business_visit_view.dart';
import 'package:hrm_app/features/requests/views/exit_and_return_visa_application_view.dart';
import 'package:hrm_app/features/requests/views/fixation_salary_view.dart';
import 'package:hrm_app/features/requests/views/griveance_view.dart';
import 'package:hrm_app/features/requests/views/job_requisition_view.dart';
import 'package:hrm_app/features/requests/views/letter_auth_request_view.dart';
import 'package:hrm_app/features/requests/views/loan_view.dart';
import 'package:hrm_app/features/requests/views/out_off_office_view.dart';
import 'package:hrm_app/features/requests/views/p_r_view.dart';
import 'package:hrm_app/features/requests/views/passport_update_view.dart';
import 'package:hrm_app/features/requests/views/purchase_request_view.dart';
import 'package:hrm_app/features/requests/views/request_to_change_a_rest_day_view.dart';
import 'package:hrm_app/features/requests/views/request_to_family_vist_auth_view.dart';
import 'package:hrm_app/features/requests/views/requests_view.dart';
import 'package:hrm_app/features/requests/views/request_details_view.dart';
import 'package:hrm_app/features/requests/views/new_request_view.dart';
import 'package:hrm_app/features/requests/views/resignation_view.dart';
import 'package:hrm_app/features/requests/views/return_to_work_from_home_view.dart';
import 'package:hrm_app/features/requests/views/salary_increase_view.dart';
import 'package:hrm_app/features/requests/views/salary_letter_view.dart';
import 'package:hrm_app/features/requests/views/training_course_view.dart';
import 'package:hrm_app/features/requests/views/travel_ticket_view.dart';
import 'package:hrm_app/features/requests/views/work_shift_change_view.dart';
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
    GetPage(
      name: '/payroll',
      page: () => PayrollView(),
      binding: BindingsBuilder(() => Get.lazyPut(() => PayrollController())),
    ),
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
    GetPage(name: '/myrequests', page: () => RequestsView()),
    GetPage(name: '/newrequests', page: () => NewRequestView()),
    GetPage(name: '/requestdetails', page: () => RequestDetailsView()),
    GetPage(name: '/letterauth', page: () => LetterAuthRequest()),
    GetPage(name: '/salaryincrease', page: () => SalaryIncreaseView()),
    GetPage(name: '/salaryletter', page: () => SalaryLetterView()),
    GetPage(name: '/workshiftchange', page: () => WorkShiftChangeView()),
    GetPage(name: '/traveticket', page: () => TravelTicketView()),
    GetPage(name: '/purchaserequest', page: () => PurchaseRequestView()),
    GetPage(name: '/loan', page: () => LoanView()),
    GetPage(
      name: '/benefitdisbursement',
      page: () => BenefitDisbursementView(),
    ),
    GetPage(name: '/outoffoffice', page: () => OutOffOfficeView()),
    GetPage(name: '/trainingcourse', page: () => TrainingCourseView()),
    GetPage(name: '/resignation', page: () => ResignationView()),
    GetPage(name: '/griveance', page: () => GriveanceView()),
    GetPage(name: '/jobrequisition', page: () => JobRequisitionView()),
    GetPage(name: '/fixationsalary', page: () => FixationSalaryView()),
    GetPage(
      name: '/requestTofamilyvistAuth',
      page: () => RequestToFamilyVistAuthView(),
    ),
    GetPage(
      name: '/requesttochangearestday',
      page: () => RequestToChangeARestDayView(),
    ),
    GetPage(name: '/applyforanother', page: () => ApplyForAnotherView()),
    GetPage(
      name: '/returntoworkfromhome',
      page: () => ReturnToWorkFromHomeView(),
    ),
    GetPage(name: '/businessvisit', page: () => BusinessVisitView()),
    GetPage(name: '/passportupdate', page: () => PassportUpdateView()),
    GetPage(
      name: '/exitandreturnvisaapplication',
      page: () => ExitAndReturnVisaApplicationView(),
    ),
    GetPage(name: '/pr', page: () => PRView()),
  ];
}
