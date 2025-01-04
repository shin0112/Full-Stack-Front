import 'dart:convert';

class User {
  int id;
  int age;
  String username;
  String password;
  double height;
  double weight;

  User({
    required this.id,
    required this.age,
    required this.username,
    required this.password,
    required this.height,
    required this.weight,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      age: json['age'] ?? 20,
      username: json['username'] ?? "",
      password: json['password'] ?? "",
      height: (json['height'] as int).toDouble() / 10,
      weight: (json['weight'] as int).toDouble() / 10,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'age': age,
      'username': username,
      'password': password,
      'height': height * 10,
      'weight': weight * 10,
    };
  }
}

Future<List<User>> parseHotlistFromJson(String jsonString) async {
  final List<dynamic> jsonData = json.decode(jsonString);
  return jsonData.map((item) => User.fromJson(item)).toList();
}
