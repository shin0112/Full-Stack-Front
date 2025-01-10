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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      age: json['age'] as int?,
      name: json['name'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
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

Future<User> parseUserFromJson(String jsonString) async {
  final List<dynamic> jsonData = json.decode(jsonString);
  return User.fromJson(jsonData[0]);
}
