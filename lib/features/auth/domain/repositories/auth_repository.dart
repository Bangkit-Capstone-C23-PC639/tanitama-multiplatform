import 'package:tanitama/core/commons/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tanitama/features/auth/domain/entities/auth.dart';
import 'package:tanitama/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, Auth>> register(User user);
  Future<Either<Failure, Auth>> login(User user);
  Future<Either<Failure, String>> saveToken(Auth auth);
  Future<Auth?> getToken();
  Future<Either<Failure, String>> logout();
}
