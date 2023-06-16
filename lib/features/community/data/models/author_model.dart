import 'package:tanitama/features/community/domain/entities/author_entity.dart';

class AuthorModel {
  final int id;
  final String name;
  final String? photo;

  AuthorModel({
    required this.id,
    required this.name,
    this.photo,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) => AuthorModel(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
      };

  AuthorEntity toEntity() => AuthorEntity(
        id: id,
        name: name,
        photo: photo,
      );
}
