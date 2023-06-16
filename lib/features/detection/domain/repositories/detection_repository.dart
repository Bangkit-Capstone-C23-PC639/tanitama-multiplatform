import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tanitama/core/commons/failure.dart';
import 'package:tanitama/features/detection/domain/entities/detection_entity.dart';

abstract class DetectionRepository {
  Future<Either<Failure, DetectionEntity>> detection(File image);
  Future<Either<Failure, List<DetectionEntity>>> detectionHistory();
  Future<Either<Failure, String>> deleteDetectionHistory(String id);
}
