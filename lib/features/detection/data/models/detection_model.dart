import 'package:tanitama/features/detection/data/models/disease_model.dart';
import 'package:tanitama/features/detection/domain/entities/detection_entity.dart';

class DetectionModel {
  final int id;
  final String imageUrl;
  final DiseaseModel disease;
  final double accuracy;
  final double timePredict;
  final String createdAt;

  DetectionModel({
    required this.id,
    required this.imageUrl,
    required this.disease,
    required this.accuracy,
    required this.timePredict,
    required this.createdAt,
  });

  factory DetectionModel.fromJson(Map<String, dynamic> json) => DetectionModel(
        id: json["id"],
        imageUrl: json["image_url"],
        disease: DiseaseModel.fromJson(json["result"]),
        accuracy: json["accuracy"]?.toDouble(),
        timePredict: json["time_predict"]?.toDouble(),
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "result": disease.toJson(),
        "accuracy": accuracy,
        "time_predict": timePredict,
        "created_at": createdAt,
      };

  DetectionEntity toEntity() {
    return DetectionEntity(
        id: id,
        imageUrl: imageUrl,
        disease: disease.toEntity(),
        accuracy: accuracy,
        timePredict: timePredict,
        createdAt: createdAt);
  }
}
