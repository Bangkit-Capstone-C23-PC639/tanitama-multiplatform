import 'package:tanitama/features/auth/domain/entities/user.dart';
import 'package:tanitama/features/community/domain/entities/commentator_entity.dart';

class CommentEntity {
  final int id;
  final int postId;
  final int userId;
  final String content;
  final String createdAt;
  final CommentatorEntity commentator;

  CommentEntity({
    required this.id,
    required this.postId,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.commentator,
  });
}
