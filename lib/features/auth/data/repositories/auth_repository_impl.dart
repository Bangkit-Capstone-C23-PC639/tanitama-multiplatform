import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:tanitama/core/commons/exception.dart';
import 'package:tanitama/core/commons/failure.dart';
import 'package:tanitama/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:tanitama/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tanitama/features/auth/domain/entities/auth.dart';
import 'package:tanitama/features/auth/domain/entities/user.dart';
import 'package:tanitama/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  var logger = Logger();

  AuthRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Auth?> getToken() async {
    final result = await localDataSource.getToken();
    return result?.toEntity();
  }

  @override
  Future<Either<Failure, Auth>> login(User user) async {
    logger.d('from login repository impl');
    try {
      final result = await remoteDataSource.login(user.email, user.password);
      return Right(result.toEntity());
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message));
    } on ServerException {
      return const Left(ServerFailure('Terjadi kesalahan pada server'));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal terhubung ke internet'));
    }
  }

  @override
  Future<Either<Failure, Auth>> register(User user) async {
    try {
      final result = await remoteDataSource.register(
          user.name!, user.email, user.password, user.passwordConfirmation!);
      return Right(result.toEntity());
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal terhubung ke internet'));
    }
  }

  @override
  Future<Either<Failure, String>> saveToken(Auth auth) async {
    try {
      final result = await localDataSource.saveToken(auth.userId!, auth.token!);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Terjadi kesalahan saat login'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> logout() async {
    final result = await localDataSource.removeToken();
    return Right(result);
  }
}
