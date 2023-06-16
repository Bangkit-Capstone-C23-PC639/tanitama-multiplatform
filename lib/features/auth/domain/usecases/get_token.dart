import 'package:tanitama/features/auth/domain/entities/auth.dart';
import 'package:tanitama/features/auth/domain/repositories/auth_repository.dart';

class GetToken {
  final AuthRepository repository;

  GetToken(this.repository);

  Future<Auth?> execute() {
    return repository.getToken();
  }
}
