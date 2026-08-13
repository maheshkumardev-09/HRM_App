import 'package:get/get.dart';
import 'package:hrm_app/features/employees/data/employees_dummy_data.dart';
import 'package:hrm_app/features/employees/models/employees_model.dart';

class EmployeesController extends GetxController {
  final employeeList = <EmployeesModel>[
    ...EmployeesDummyData.employees.map((e) => EmployeesModel.fromJson(e)),
  ].obs;
  final filteredList = <EmployeesModel>[].obs;
  final selectedDepartment = 'All Departments'.obs;
  final selectedPosition = 'All Positions'.obs;
  final searchText = ''.obs;
  final departmentList = [
    'All Departments',
    'Finance',
    'IT',
    'Engineering',
    'Management',
    'Human Resource',
    'Development',
  ];
  final positionList = [
    'All Positions',
    'Accountant',
    'ICT Lines Installer',
    'Mechanical Engineer',
    'Manager',
    'HR Officer',
    'Software Developer',
  ];
  @override
  void onInit() {
    super.onInit();
    filteredList.assignAll(employeeList);
  }

  void apllyFilter() {
    filteredList.assignAll(
      employeeList.where((employee) {
        final matchName =
            searchText.isEmpty ||
            employee.name.toLowerCase().contains(
              searchText.value.toLowerCase(),
            );

        final matchDepartment =
            selectedDepartment.value == 'All Departments' ||
            employee.department == selectedDepartment.value;
        final matchPosition =
            selectedPosition.value == 'All Positions' ||
            employee.position == selectedPosition.value;

        return matchName && matchDepartment && matchPosition;
      }).toList(),
    );
  }
}
