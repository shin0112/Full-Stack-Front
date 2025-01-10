import 'dart:convert';

class Record {
  int id;
  int userId;
  int? brandId;
  double caffeine;
  String title;
  String detail;
  DateTime createdAt;

  Record({
    required this.id,
    required this.userId,
    required this.caffeine,
    required this.title,
    this.brandId,
    required this.detail,
    required this.createdAt,
  });

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      id: json["id"] as int,
      userId: json["userId"] as int,
      brandId: json["brandId"] as int?,
      caffeine: json["caffeine"] as double,
      title: json["title"] as String,
      detail: json["detail"] as String,
      createdAt: DateTime.parse(json["createdAt"] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'brandId': brandId,
      'caffeine': caffeine,
      'title': title,
      'detail': detail,
      'createdAt': createdAt,
    };
  }
}

Future<List<Record>> parseRecordFromJson(String jsonString) async {
  final List<dynamic> jsonData = json.decode(jsonString);
  return jsonData.map((item) => Record.fromJson(item)).toList();
}
