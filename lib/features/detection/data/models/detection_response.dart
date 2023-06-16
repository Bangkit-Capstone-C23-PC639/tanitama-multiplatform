import 'package:tanitama/features/detection/data/models/detection_model.dart';

class DetectionResponse {
  final DetectionModel detectionModel;

  DetectionResponse({required this.detectionModel});

  factory DetectionResponse.fromJson(Map<String, dynamic> json) =>
      DetectionResponse(
        detectionModel: DetectionModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": detectionModel.toJson(),
      };
}
