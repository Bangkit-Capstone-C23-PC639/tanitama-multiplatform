import 'package:equatable/equatable.dart';
import 'package:tanitama/features/detection/domain/entities/detection_entity.dart';

class DetectionDetailEntity extends Equatable {
  final String type;
  final DetectionEntity detection;

  const DetectionDetailEntity({
    required this.type,
    required this.detection,
  });

  @override
  List<Object?> get props => [type, detection];
}
