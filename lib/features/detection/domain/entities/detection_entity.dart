import 'package:equatable/equatable.dart';
import 'package:tanitama/features/detection/domain/entities/disease.dart';

class DetectionEntity extends Equatable {
  final int id;
  final String imageUrl;
  final Disease disease;
  final double accuracy;
  final double timePredict;
  final String createdAt;

  const DetectionEntity({
    required this.id,
    required this.imageUrl,
    required this.disease,
    required this.accuracy,
    required this.timePredict,
    required this.createdAt,
  });

  @override
  List<Object?> get props =>
      [id, imageUrl, disease, accuracy, timePredict, createdAt];
}
