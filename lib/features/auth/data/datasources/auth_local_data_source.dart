import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tanitama/features/auth/data/models/auth_model.dart';

abstract class AuthLocalDataSource {
  Future<String> saveToken(int userId, String token);
  Future<String> removeToken();
  Future<AuthModel?> getToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;

  AuthLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<AuthModel?> getToken() async {
    final token = await secureStorage.read(key: "access-token");
    final userId = await secureStorage.read(key: "user-id");

    if (token == null || userId == null) {
      return null;
    }

    return AuthModel(userId: int.parse(userId), token: token);
  }

  @override
  Future<String> removeToken() async {
    await secureStorage.delete(key: "access-token");
    await secureStorage.delete(key: "user-id");
    return "Token deleted";
  }

  @override
  Future<String> saveToken(int userId, String token) async {
    await secureStorage.write(key: "access-token", value: token);
    await secureStorage.write(key: "user-id", value: userId.toString());
    return "Token saved";
  }
}
