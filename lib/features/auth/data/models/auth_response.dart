import 'package:tanitama/features/auth/data/models/auth_model.dart';

class AuthResponse {
  final AuthModel authModel;

  AuthResponse({required this.authModel});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      AuthResponse(authModel: AuthModel.fromJson(json));
}
