class CountryModel {
  CountryModel({
    required this.emoji,
    required this.name,
    required this.capital,
    required this.code,
    required this.phone,
    required this.continentName,
  });

  final String code;
  final String name;
  final String emoji;
  final String capital;
  final String phone;
  final String continentName;

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      emoji: json["emoji"] as String? ?? "",
      name: json["name"] as String? ?? "",
      capital: json["capital"] as String? ?? "",
      code: json["code"] as String? ?? "",
      phone: json["phone"] as String? ?? "",
      continentName: json["continent"]["name"] as String? ?? "",
    );
  }
}

class AllCountryModel {
  AllCountryModel({
    required this.emoji,
    required this.name,
    required this.capital,
    required this.code,
  });

  final String code;
  final String name;
  final String emoji;
  final String capital;

  factory AllCountryModel.fromJson(Map<String, dynamic> json) {
    return AllCountryModel(
      emoji: json["emoji"] as String? ?? "",
      name: json["name"] as String? ?? "",
      capital: json["capital"] as String? ?? "",
      code: json["code"] as String? ?? "",
    );
  }
}
