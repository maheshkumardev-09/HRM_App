import 'package:get/get.dart';
import 'package:hrm_app/features/time_sheets/models/time_sheet_model.dart';

class TimeSheetController extends GetxController {
  var timesheetList = <TimesheetModel>[
    TimesheetModel(
      taskId: "1",
      date: "2026-04-05",
      employeeName: "M.Ahmad",
      description: "This is description of task2...",
      hoursSpent: 5.5,
      taskTitle: "Repairing",
      projectName: "Aman Al Bilad",
    ),
    TimesheetModel(
      taskId: "1",
      date: "2026-04-05",
      employeeName: "M.Ahmad",
      description: "This is description of task2...",
      hoursSpent: 2.0,
      taskTitle: "Work of Electrical Wiring",
      projectName: "Prime Stats",
    ),
    TimesheetModel(
      taskId: "2",
      date: "2026-04-06",
      employeeName: "Ali Khan",
      description: "Inspected pipelines",
      hoursSpent: 3.0,
      taskTitle: "Repairing",
      projectName: "Aman Al Bilad",
    ),
    // ... baaki saare entries jo pehle TaskModel ke andar the
  ].obs;

  List<TimesheetModel> getEntriesByTask(String taskId) {
    return timesheetList.where((entry) => entry.taskId == taskId).toList();
  }
}
