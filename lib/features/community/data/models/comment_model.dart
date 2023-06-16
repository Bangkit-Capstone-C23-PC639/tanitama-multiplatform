import 'package:tanitama/features/auth/data/models/user_model.dart';
import 'package:tanitama/features/community/data/models/comentator_model.dart';
import 'package:tanitama/features/community/domain/entities/comment_entity.dart';

class CommentModel {
  final int id;
  final int postId;
  final int userId;
  final String content;
  final String createdAt;
  final CommentatorModel commentator;

  CommentModel({
    required this.id,
    required this.postId,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.commentator,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json["id"],
        postId: json["post_id"],
        userId: json["user_id"],
        content: json["content"],
        createdAt: json["created_at"],
        commentator: CommentatorModel.fromJson(json["commentator"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "post_id": postId,
        "user_id": userId,
        "content": content,
        "created_at": createdAt,
        "commentator": commentator.toJson(),
      };

  CommentEntity toEntity() => CommentEntity(
        id: id,
        postId: postId,
        userId: userId,
        content: content,
        createdAt: createdAt,
        commentator: commentator.toEntity(),
      );
}
