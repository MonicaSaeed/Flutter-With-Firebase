class PostModel {
  String id;
  final String content;
  final String author;
  final String authorId;
  DateTime createdAt;
  DateTime updatedAt;

  PostModel({
    this.id = '',
    required this.content,
    required this.author,
    required this.authorId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  PostModel.fromMap(Map<String, dynamic> json)
    : id = json['id'] ?? '',
      content = json['content'] ?? '',
      author = json['author'] ?? '',
      authorId = json['authorId'] ?? '',
      createdAt = DateTime.parse(json['createdAt']),
      updatedAt = DateTime.parse(json['createdAt']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'author': author,
      'authorId': authorId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'PostModel{id: $id, content: $content, author: $author, autherId: $authorId ,createdAt: $createdAt}';
  }
}
