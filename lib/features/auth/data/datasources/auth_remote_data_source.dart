import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:tanitama/core/commons/constants.dart';
import 'package:tanitama/core/commons/exception.dart';
import 'package:tanitama/features/auth/data/models/auth_error_response.dart';
import 'package:tanitama/features/auth/data/models/auth_model.dart';
import 'package:tanitama/features/auth/data/models/auth_response.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<AuthModel> login(String email, String password);
  Future<AuthModel> register(
      String name, String email, String password, String passwordConfirmation);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final FlutterSecureStorage storage;

  var logger = Logger();

  AuthRemoteDataSourceImpl({required this.client, required this.storage});

  @override
  Future<AuthModel> login(String email, String password) async {
    final body = json.encode({
      "email": email,
      "password": password,
    });

    final response = await client.post(Uri.parse('$baseUrlApi/login'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: body);

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(jsonDecode(response.body)).authModel;
    } else if (response.statusCode == 400) {
      throw AuthenticationException(
          AuthErrorResponse.fromJson(jsonDecode(response.body)).message);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AuthModel> register(String name, String email, String password,
      String passwordConfirmation) async {
    final body = json.encode({
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation
    });

    final response = await client.post(Uri.parse('$baseUrlApi/register'),
        headers: {
          "Content-Type": "application/json",
        },
        body: body);

    logger.d(response.body);
    logger.d(response.statusCode);

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(jsonDecode(response.body)).authModel;
    } else if (response.statusCode == 302) {
      throw AuthenticationException('Pastikan data terisi dengan benar');
    } else {
      throw ServerException();
    }
  }
}
