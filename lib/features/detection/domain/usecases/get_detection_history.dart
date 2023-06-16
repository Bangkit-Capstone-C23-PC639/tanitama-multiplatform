import 'package:dartz/dartz.dart';
import 'package:tanitama/core/commons/failure.dart';
import 'package:tanitama/features/detection/domain/entities/detection_entity.dart';
import 'package:tanitama/features/detection/domain/repositories/detection_repository.dart';

class GetDetectionHistory {
  final DetectionRepository repository;

  GetDetectionHistory(this.repository);

  Future<Either<Failure, List<DetectionEntity>>> execute() {
    return repository.detectionHistory();
  }
}
