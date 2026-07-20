class UserMoel {
  final String name;
  final String profileImage;
  final String email;
  final String? designation;
  final String? phoneNumber;

  UserMoel({
    required this.name,
    required this.profileImage,
    required this.email,
    this.designation,
    this.phoneNumber,
  });
}
