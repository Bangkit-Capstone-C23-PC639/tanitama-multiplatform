import 'package:dartz/dartz.dart';
import 'package:tanitama/core/commons/failure.dart';
import 'package:tanitama/features/detection/domain/repositories/detection_repository.dart';

class DeleteDetectionHistory {
  final DetectionRepository repository;

  DeleteDetectionHistory(this.repository);

  Future<Either<Failure, String>> execute(String id) {
    return repository.deleteDetectionHistory(id);
  }
}
