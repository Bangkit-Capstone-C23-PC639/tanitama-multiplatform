import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tanitama/core/commons/exception.dart';
import 'package:tanitama/core/commons/failure.dart';
import 'package:tanitama/features/community/data/datasources/community_remote_data_source.dart';
import 'package:tanitama/features/community/data/models/post_model.dart';
import 'package:tanitama/features/community/domain/entities/post_entity.dart';
import 'package:tanitama/features/community/domain/repositories/community_repository.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityRemoteDataSource remoteDataSource;

  CommunityRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    try {
      final result = await remoteDataSource.getAllPosts();
      return Right(result.map((data) => data.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure('Terjadi kesalahan pada server'));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal terhubung ke internet'));
    }
  }

  @override
  Future<Either<Failure, PostEntity>> getPostById(int id) async {
    try {
      final result = await remoteDataSource.getPostById(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('Terjadi kesalahan pada server'));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal terhubung ke internet'));
    }
  }

  @override
  Future<Either<Failure, String>> createComment(int id, String content) async {
    try {
      final result = await remoteDataSource.createComment(id, content);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Terjadi kesalahan pada server'));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal terhubung ke internet'));
    }
  }

  @override
  Future<Either<Failure, String>> createPost(
      String title, String content, File image) async {
    try {
      final result = await remoteDataSource.createPost(title, content, image);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Terjadi kesalahan pada server'));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal terhubung ke internet'));
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getPostsByUser() async {
    try {
      final result = await remoteDataSource.getPostsByUser();
      return Right(result.map((post) => post.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure('Terjadi kesalahan pada server'));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal terhubung ke internet'));
    }
  }

  @override
  Future<Either<Failure, String>> deletePost(int id) async {
    try {
      final result = await remoteDataSource.deletePost(id);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Terjadi kesalahan pada server'));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal terhubung ke internet'));
    }
  }

  @override
  Future<Either<Failure, String>> deleteComment(int id) async {
    try {
      final result = await remoteDataSource.deleteComment(id);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Terjadi kesalahan pada server'));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal terhubung ke internet'));
    }
  }
}
