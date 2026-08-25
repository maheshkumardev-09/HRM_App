class UserMoel {
  final String id;
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
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "email": email, "password": password};
  }

  factory UserMoel.formjson(Map<String, dynamic> json) {
    return UserMoel(
      name: json["name"],
      email: json["email"],
      password: json["password"],
      id: json['id'],
    );
  }
}
