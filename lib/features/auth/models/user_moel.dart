class UserMoel {
  final String name;
  final String? profileImage;
  final String email;
  final String password;
  final String? designation;
  final String? phoneNumber;

  UserMoel({
    required this.name,
    this.profileImage,
    required this.email,
    this.designation,
    this.phoneNumber,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {"name": name, "email": email, "password": password};
  }

  factory UserMoel.formjson(Map<String, dynamic> json) {
    return UserMoel(
      name: json["name"],
      email: json["email"],
      password: json["password"],
    );
  }
}
