import 'package:tanitama/features/community/domain/entities/comment_entity.dart';
import 'package:tanitama/features/community/domain/entities/commentator_entity.dart';

class CommentatorModel {
  final int id;
  final String name;
  final String email;
  final String photo;
  final String createdAt;
  final String updatedAt;

  CommentatorModel({
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CommentatorModel.fromJson(Map<String, dynamic> json) =>
      CommentatorModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        photo: json["photo"],
        createdAt: json["created_at"],
        updatedAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "photo": photo,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  CommentatorEntity toEntity() => CommentatorEntity(
      id: id,
      name: name,
      email: email,
      photo: photo,
      createdAt: createdAt,
      updatedAt: updatedAt);
}
