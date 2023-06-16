import 'package:dartz/dartz.dart';
import 'package:tanitama/core/commons/failure.dart';
import 'package:tanitama/features/auth/domain/entities/user.dart';
import 'package:tanitama/features/auth/domain/repositories/auth_repository.dart';

class AuthRegister {
  final AuthRepository repository;

  AuthRegister(this.repository);

  Future<Either<Failure, String>> execute(User user) {
    return repository.register(user);
  }
}
