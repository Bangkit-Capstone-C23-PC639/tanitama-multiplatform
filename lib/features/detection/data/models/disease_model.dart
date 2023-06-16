import 'package:tanitama/features/detection/domain/entities/disease.dart';

class DiseaseModel {
  final int id;
  final String name;
  final String description;
  final String recomendation;
  final String sampleImg;
  String? createdAt;
  String? updatedAt;

  DiseaseModel({
    required this.id,
    required this.name,
    required this.description,
    required this.recomendation,
    required this.sampleImg,
    this.createdAt,
    this.updatedAt,
  });

  factory DiseaseModel.fromJson(Map<String, dynamic> json) => DiseaseModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        recomendation: json["recomendation"],
        sampleImg: json["sample_img"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "recomendation": recomendation,
        "sample_img": sampleImg,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  Disease toEntity() {
    return Disease(
        id: id,
        name: name,
        description: description,
        recomendation: recomendation,
        sampleImg: sampleImg,
        createdAt: createdAt,
        updatedAt: updatedAt);
  }
}
