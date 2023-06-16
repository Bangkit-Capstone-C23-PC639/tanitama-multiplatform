import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tanitama/core/commons/failure.dart';
import 'package:tanitama/features/detection/domain/entities/detection_entity.dart';
import 'package:tanitama/features/detection/domain/repositories/detection_repository.dart';

class GetDetection {
  final DetectionRepository repository;

  GetDetection(this.repository);

  Future<Either<Failure, DetectionEntity>> execute(File image) {
    return repository.detection(image);
  }
}
