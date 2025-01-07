import 'dart:convert';

class Brand {
  int id;
  String name;
  double shot;

  Brand({
    required this.id,
    required this.name,
    required this.shot,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'] as int,
      name: json['name'] as String,
      shot: json['shot'] as double,
    );
  }
}

Future<List<List<Brand>>> parseBrandFromJson(String jsonString) async {
  final List<dynamic> jsonData = json.decode(jsonString);
  return jsonData.map((items) {
    return (items as List).map((item) => Brand.fromJson(item)).toList();
  }).toList();
}
