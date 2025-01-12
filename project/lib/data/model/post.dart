class Post {
  int id;
  int userId;
  String title;
  String content;
  String img;
  int like;
  bool isLike;
  String createdAt;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.img,
    required this.like,
    required this.isLike,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] ?? "",
      content: json['content'] ?? "",
      img: json['img'] ?? "",
      like: json['like'] as int,
      isLike: json['isLike'] as bool,
      createdAt: json['createdAt'] ?? DateTime.now().toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'content': content,
      'img': img,
      'like': like,
      'isLike': isLike,
      'createdAt': createdAt,
    };
  }
}

Future<List<Post>> parsePostFromJson(List<dynamic> jsonData) async {
  return jsonData.map((item) => Post.fromJson(item)).toList();
}
