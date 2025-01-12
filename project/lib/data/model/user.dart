import 'package:hive_ce/hive.dart';

class User extends HiveObject {
  int id;
  int age;
  String name;
  String username;
  double height;
  double weight;

  User({
    this.id = 0,
    this.age = 20,
    this.name = "user",
    this.username = "",
    this.height = 175.0,
    this.weight = 60.0,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      age: map['age'] as int,
      name: map['name'] as String,
      username: map['username'] as String,
      height: map['height'] as double,
      weight: map['weight'] as double,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'age': age,
  //     'name': name,
  //     'username': username,
  //     'height': height * 10,
  //     'weight': weight * 10,
  //   };
  // }
}
