import 'dart:convert';

class Post {
  int? id;
  int? userId;
  String? title;
  String? context;
  String? img;
  int? like;
  String? createdAt;

  Post({
    this.id,
    this.userId,
    this.title,
    this.context,
    this.img,
    this.like,
    this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      title: json['title'] ?? "",
      context: json['context'] ?? "",
      img: json['img'] ?? "",
      like: json['like'] ?? 0,
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
