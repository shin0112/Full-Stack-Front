import 'dart:convert';

class Hotlist {
  int id;
  String name;
  String detail;
  double caffeine;

  Hotlist({
    required this.id,
    required this.name,
    required this.detail,
    required this.caffeine,
  });

  Map<String, Object?> toMap() {
    final map = <String, Object?>{
      'id': id,
      'name': name,
      'detail': detail,
      'caffeine': caffeine,
    };

    return map;
  }

  factory Hotlist.fromMap(Map<String, Object?> map) {
    return Hotlist(
      id: map['id'] as int,
      name: map['name'] as String,
      detail: map['detail'] as String,
      caffeine: map['caffeine'] as double,
    );
  }
}

Future<List<Hotlist>> parseHotlistFromJson(String jsonString) async {
  final List<dynamic> jsonData = json.decode(jsonString);
  return jsonData.map((item) => Hotlist.fromMap(item)).toList();
}
