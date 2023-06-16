import 'package:dartz/dartz.dart';
import 'package:tanitama/core/commons/failure.dart';
import 'package:tanitama/features/auth/domain/entities/auth.dart';
import 'package:tanitama/features/auth/domain/repositories/auth_repository.dart';

class SaveToken {
  final AuthRepository repository;

  SaveToken(this.repository);

  Future<Either<Failure, String>> execute(Auth auth) {
    return repository.saveToken(auth);
  }
}
