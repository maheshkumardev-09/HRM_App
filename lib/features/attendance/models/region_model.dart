class RegionModel {
  final String country;
  final String city;

  RegionModel({required this.country, required this.city});

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(country: json['country'], city: json['city']);
  }

  Map<String, dynamic> toJson() {
    return {'country': country, 'city': city};
  }
}
