class ServerException implements Exception {}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException(this.message);
}
