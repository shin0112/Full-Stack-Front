class Hotlist {
  int? id;
  String name;
  String detail;
  double caffeine;

  Hotlist({
    this.id,
    required this.name,
    required this.detail,
    required this.caffeine,
  });

  Map<String, Object?> toMap() {
    final map = <String, Object?>{
      'name': name,
      'detail': detail,
      'caffeine': caffeine,
    };

    if (id != null) {
      map['id'] = id;
    }

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

  @override
  String toString() {
    return 'Hotlist{id: $id, name: $name, detail: $detail, caffeine: $caffeine}';
  }
}
