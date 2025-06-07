import 'package:flutter_app/core/extensions/extensions.dart';

class PostModel {
  String id;
  final String content;
  final String authorId;
  DateTime createdAt;
  DateTime updatedAt;

  PostModel({
    this.id = '',
    required this.content,
    required this.authorId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  PostModel.fromMap(Map<String, dynamic> json)
    : id = json['id'] ?? '',
      content = json['content'] ?? '',
      authorId = json['authorId'] ?? '',
      createdAt = json.getParsedDate('createdAt'),
      updatedAt = json.getParsedDate(
        'updatedAt',
        fallback: json.getParsedDate('createdAt'),
      );

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'authorId': authorId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'PostModel{id: $id, content: $content, autherId: $authorId ,createdAt: $createdAt}';
  }
}
