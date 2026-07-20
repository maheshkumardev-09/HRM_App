import 'package:get/get.dart';
import 'package:hrm_app/constants/app_image.dart';
import 'package:hrm_app/features/employees/models/employees_model.dart';

class EmployeesController extends GetxController {
  var employList = <EmployeesModel>[
    EmployeesModel(
      empolyeeImage: AppImages.profileImage,
      name: 'Abdullah Omer Mohammed',
      category: 'Accounant',
    ),
    EmployeesModel(
      empolyeeImage: AppImages.profileImage,
      name: 'Ali Muhammad',
      category: 'ICT Lines Installer',
    ),
    EmployeesModel(
      empolyeeImage: AppImages.profileImage,
      name: 'Ahmed Abdul Rahem',
      category: 'Mechanical Engineer',
    ),
    EmployeesModel(
      empolyeeImage: AppImages.profileImage,
      name: 'Asad',
      category: 'Manager',
    ),
    EmployeesModel(
      empolyeeImage: AppImages.profileImage,
      name: 'Ali Muhammad',
      category: 'ICT Lines Installer',
    ),
  ].obs;
}
