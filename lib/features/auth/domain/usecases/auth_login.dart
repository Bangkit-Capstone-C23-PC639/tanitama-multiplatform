import 'package:dartz/dartz.dart';
import 'package:tanitama/core/commons/failure.dart';
import 'package:tanitama/features/auth/domain/entities/auth.dart';
import 'package:tanitama/features/auth/domain/entities/user.dart';
import 'package:tanitama/features/auth/domain/repositories/auth_repository.dart';

class AuthLogin {
  final AuthRepository repository;

  AuthLogin(this.repository);

  Future<Either<Failure, Auth>> execute(User user) {
    return repository.login(user);
  }
}
