class EmployeesModel {
  final String id;
  final String employeeImage;
  final String name;
  final String position;
  final String email;
  final String phone;
  final String department;

  EmployeesModel({
    required this.id,
    required this.employeeImage,
    required this.name,
    required this.position,
    required this.email,
    required this.phone,
    required this.department,
  });
  factory EmployeesModel.fromJson(Map<String, dynamic> json) {
    return EmployeesModel(
      id: json['id'],
      employeeImage: json['employeeImage'],
      name: json['name'],
      position: json['position'],
      email: json['email'],
      phone: json['phone'],
      department: json['department'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeImage': employeeImage,
      'name': name,
      'position': position,
      'email': email,
      'phone': phone,
      'department': department,
    };
  }
}
