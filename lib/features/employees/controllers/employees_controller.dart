import 'package:get/get.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/features/employees/models/employees_model.dart';

class EmployeesController extends GetxController {
  final employeeList = <EmployeesModel>[
    EmployeesModel(
      id: '001',
      empolyeeImage: AppImages.profileImage,
      name: 'Abdullah Omer Mohammed',
      category: 'Accountant',
      email: 'abdullah.omer@gmail.com',
      phone: '+92 300 1234567',
      department: 'Finance',
    ),

    EmployeesModel(
      id: '002',
      empolyeeImage: AppImages.profileImage,
      name: 'Ali Muhammad',
      category: 'ICT Lines Installer',
      email: 'ali.muhammad@gmail.com',
      phone: '+92 301 2345678',
      department: 'IT',
    ),

    EmployeesModel(
      id: '003',
      empolyeeImage: AppImages.profileImage,
      name: 'Ahmed Abdul Rahem',
      category: 'Mechanical Engineer',
      email: 'ahmed.rahem@gmail.com',
      phone: '+92 302 3456789',
      department: 'Engineering',
    ),

    EmployeesModel(
      id: '004',
      empolyeeImage: AppImages.profileImage,
      name: 'Asad Khan',
      category: 'Manager',
      email: 'asad.khan@gmail.com',
      phone: '+92 303 4567890',
      department: 'Management',
    ),

    EmployeesModel(
      id: '005',
      empolyeeImage: AppImages.profileImage,
      name: 'Sara Ahmed',
      category: 'HR Officer',
      email: 'sara.ahmed@gmail.com',
      phone: '+92 304 5678901',
      department: 'Human Resource',
    ),

    EmployeesModel(
      id: '006',
      empolyeeImage: AppImages.profileImage,
      name: 'Usman Ali',
      category: 'Software Developer',
      email: 'usman.ali@gmail.com',
      phone: '+92 305 6789012',
      department: 'Development',
    ),
  ].obs;

  // EmployeesModel? getEmployeeById(String id) {
  //   return employeeList.firstWhereOrNull((emp) => emp.id == id);
  // }
}
