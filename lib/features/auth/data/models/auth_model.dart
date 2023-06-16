import 'package:tanitama/features/auth/domain/entities/auth.dart';

class AuthModel {
  final int userId;
  final String token;

  AuthModel({required this.userId, required this.token});

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        userId: json['user']['id'],
        token: json['token'],
      );

  Auth toEntity() {
    return Auth(userId: userId, token: token);
  }
}
