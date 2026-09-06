import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:hrm_app/features/auth/controllers/auth_controller.dart';
import 'package:hrm_app/features/expenses/controllers/expenses_controller.dart';
import 'package:hrm_app/features/notifications/controllers/announcement_controller.dart';
import 'package:hrm_app/features/projects/controllers/project_controller.dart';
import 'package:hrm_app/features/projects/controllers/task_controller.dart';
import 'package:hrm_app/features/requests/controllers/requests_controller.dart';
import 'package:hrm_app/features/time_off/controllers/time_off_controller.dart';
import 'package:hrm_app/features/time_sheets/controllers/timesheet_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.lazyPut<TimeSheetController>(() => TimeSheetController(), fenix: true);
    Get.lazyPut<ExpensesController>(() => ExpensesController(), fenix: true);
    Get.lazyPut<AnnouncementController>(
      () => AnnouncementController(),
      fenix: true,
    );
    Get.lazyPut<TimeOffController>(() => TimeOffController(), fenix: true);
    Get.lazyPut<ProjectController>(() => ProjectController(), fenix: true);
    Get.lazyPut<TaskController>(() => TaskController(), fenix: true);
    Get.lazyPut<RequestsController>(() => RequestsController(), fenix: true);
  }
}
