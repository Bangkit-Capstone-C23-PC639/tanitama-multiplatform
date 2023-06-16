import 'package:tanitama/features/community/domain/entities/author_entity.dart';
import 'package:tanitama/features/community/domain/entities/comment_entity.dart';

class PostEntity {
  final int id;
  final String title;
  final String? content;
  final String? imageUrl;
  final AuthorEntity author;
  final String createdAt;
  final int? totalComments;
  final List<CommentEntity>? comments;

  PostEntity({
    required this.id,
    required this.title,
    this.content,
    this.imageUrl,
    required this.author,
    required this.createdAt,
    this.totalComments,
    this.comments,
  });
}
