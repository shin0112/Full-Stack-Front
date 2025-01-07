import 'dart:convert';

class Beverage {
  int id;
  int brandId;
  String name;
  double caffeine;

  Beverage({
    required this.id,
    required this.brandId,
    required this.name,
    required this.caffeine,
  });

  factory Beverage.fromJson(Map<String, dynamic> json) {
    return Beverage(
      id: json['id'] as int,
      brandId: json['brandId'] as int,
      name: json['name'] as String,
      caffeine: json['caffeine'] as double,
    );
  }
}

Future<List<Beverage>> parseBeverageFromJson(String jsonString) async {
  final List<dynamic> jsonData = json.decode(jsonString);
  return jsonData.map((item) => Beverage.fromJson(item)).toList();
}
