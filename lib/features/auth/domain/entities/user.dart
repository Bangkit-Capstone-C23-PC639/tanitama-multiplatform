class User {
  final String? name;
  final String email;
  final String password;
  final String? passwordConfirmation;

  User({
    this.name,
    required this.email,
    required this.password,
    this.passwordConfirmation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }
}
