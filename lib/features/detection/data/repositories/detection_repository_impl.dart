import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tanitama/core/commons/exception.dart';
import 'package:tanitama/core/commons/failure.dart';
import 'package:tanitama/features/detection/data/datasources/detection_remote_data_source.dart';
import 'package:tanitama/features/detection/domain/entities/detection_entity.dart';
import 'package:tanitama/features/detection/domain/repositories/detection_repository.dart';

class DetectionRepositoryImpl implements DetectionRepository {
  final DetectionRemoteDataSource remoteDataSource;

  DetectionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, DetectionEntity>> detection(File image) async {
    try {
      final result = await remoteDataSource.detection(image);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('Terjadi kesalahan pada server'));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal terhubung ke internet'));
    }
  }

  @override
  Future<Either<Failure, List<DetectionEntity>>> detectionHistory() async {
    try {
      final result = await remoteDataSource.detectionHistory();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure('Terjadi kesalahan pada server'));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal terhubung ke internet'));
    }
  }

  @override
  Future<Either<Failure, String>> deleteDetectionHistory(String id) async {
    try {
      final result = await remoteDataSource.deleteDetectionHistory(id);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Terjadi kesalahan pada server'));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal terhubung ke internet'));
    }
  }
}
