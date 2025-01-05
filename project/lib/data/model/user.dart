import 'dart:convert';

class User {
  int? id;
  int? age;
  String? name;
  String? username;
  String? password;
  double? height;
  double? weight;

  User({
    this.id,
    this.age,
    this.name,
    this.username,
    this.password,
    this.height,
    this.weight,
  });

  factory User.testUser() {
    return User(
      id: 0,
      age: 20,
      height: 173.9,
      name: "아무개",
      password: "",
      username: "",
      weight: 63.2,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      age: json['age'] ?? 20,
      name: json['name'] ?? "",
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
      'name': name,
      'username': username,
      'password': password,
      'height': height! * 10,
      'weight': weight! * 10,
    };
  }
}

Future<List<User>> parseUserFromJson(String jsonString) async {
  final List<dynamic> jsonData = json.decode(jsonString);
  return jsonData.map((item) => User.fromJson(item)).toList();
}
