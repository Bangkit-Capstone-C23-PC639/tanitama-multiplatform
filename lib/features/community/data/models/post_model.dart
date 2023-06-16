import 'package:tanitama/features/community/data/models/author_model.dart';
import 'package:tanitama/features/community/data/models/comment_model.dart';
import 'package:tanitama/features/community/domain/entities/post_entity.dart';

class PostModel {
  final int id;
  final String title;
  final String? content;
  final String? imageUrl;
  final AuthorModel author;
  final String createdAt;
  final int? totalComments;
  final List<CommentModel>? comments;

  PostModel({
    required this.id,
    required this.title,
    this.content,
    this.imageUrl,
    required this.author,
    required this.createdAt,
    this.totalComments,
    this.comments,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"],
        title: json["title"],
        content: json['content'],
        imageUrl: json["image_url"],
        author: AuthorModel.fromJson(json["author"]),
        createdAt: json["created_at"],
        totalComments: json["total_comments"],
        comments: json["comments"] != null
            ? List<CommentModel>.from(json["comments"]
                .map((comment) => CommentModel.fromJson(comment)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "image_url": imageUrl,
        "author": author.toJson(),
        "created_at": createdAt,
        "total_comments": totalComments,
        "comments": comments,
      };

  PostEntity toEntity() => PostEntity(
      id: id,
      title: title,
      content: content,
      imageUrl: imageUrl,
      author: author.toEntity(),
      createdAt: createdAt,
      totalComments: totalComments,
      comments: comments?.map((comment) => comment.toEntity()).toList());
}
