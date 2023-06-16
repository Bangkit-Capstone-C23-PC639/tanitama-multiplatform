import 'package:tanitama/features/detection/data/models/detection_model.dart';

class DetectionHistoryResponse {
  final List<DetectionModel> detectionModel;

  DetectionHistoryResponse({required this.detectionModel});

  factory DetectionHistoryResponse.fromJson(Map<String, dynamic> json) =>
      DetectionHistoryResponse(
        detectionModel: List<DetectionModel>.from(
            json['data'].map((data) => DetectionModel.fromJson(data))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(detectionModel.map((x) => x.toJson())),
      };
}
