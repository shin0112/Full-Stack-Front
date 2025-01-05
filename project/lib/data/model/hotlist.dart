import 'dart:convert';

class Hotlist {
  int id;
  int userId;
  String title;
  String detail;
  double caffeine;

  Hotlist({
    required this.id,
    required this.userId,
    required this.title,
    required this.detail,
    required this.caffeine,
  });

  factory Hotlist.fromJson(Map<String, dynamic> json) {
    return Hotlist(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      detail: json['detail'] as String,
      caffeine: (json['caffeine'] as int).toDouble() / 10,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'detail': detail,
      'caffeine': caffeine * 10,
    };
  }
}

Future<List<Hotlist>> parseHotlistFromJson(String jsonString) async {
  final List<dynamic> jsonData = json.decode(jsonString);
  return jsonData.map((item) => Hotlist.fromJson(item)).toList();
}
