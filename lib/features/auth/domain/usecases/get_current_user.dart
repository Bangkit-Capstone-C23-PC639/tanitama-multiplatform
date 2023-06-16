import 'package:tanitama/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUser {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  Future<String?> execute() {
    return repository.getToken();
  }
}
