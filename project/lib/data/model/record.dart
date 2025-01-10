class Record {
  int? id;
  int? brandId;
  double caffeine;
  String title;
  String detail;
  DateTime createdAt;

  Record({
    this.id,
    this.brandId,
    required this.caffeine,
    required this.title,
    required this.detail,
    required this.createdAt,
  });

  Map<String, Object?> toMap() {
    final map = <String, Object?>{
      'brandId': brandId,
      'caffeine': caffeine,
      'title': title,
      'detail': detail,
      'createdAt': createdAt,
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory Record.fromMap(Map<String, Object?> map) {
    return Record(
      id: map["id"] as int,
      brandId: map["brandId"] as int?,
      caffeine: map["caffeine"] as double,
      title: map["title"] as String,
      detail: map["detail"] as String,
      createdAt: DateTime.parse(map["createdAt"] as String),
    );
  }
}
