import 'dart:convert';

class Post {
  int id;
  int userId;
  String title;
  String context;
  String img;
  int like;
  String createdAt;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.context,
    required this.img,
    required this.like,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] ?? "",
      context: json['context'] ?? "",
      img: json['img'] ?? "",
      like: json['like'] as int,
      createdAt: json['createdAt'] ?? DateTime.now().toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'context': context,
      'img': img,
      'like': like,
      'createdAt': createdAt,
    };
  }
}

Future<List<Post>> parsePostFromJson(String jsonString) async {
  final List<dynamic> jsonData = json.decode(jsonString);
  return jsonData.map((item) => Post.fromJson(item)).toList();
}
