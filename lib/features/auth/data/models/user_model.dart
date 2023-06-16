import 'dart:convert';

import 'package:tanitama/features/auth/domain/entities/user.dart';

class UserModel {
  final String email;
  final String password;
  UserModel({
    required this.email,
    required this.password,
  });

  UserModel copyWith({
    String? email,
    String? password,
  }) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      email: user.email,
      password: user.password,
    );
  }

  User toEntity() => User(
        email: email,
        password: password,
      );

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(email: $email, password: $password)';
}
