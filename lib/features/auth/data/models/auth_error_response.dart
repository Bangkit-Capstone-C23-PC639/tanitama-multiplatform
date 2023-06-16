class AuthErrorResponse {
  final String message;

  AuthErrorResponse({required this.message});

  factory AuthErrorResponse.fromJson(Map<String, dynamic> json) =>
      AuthErrorResponse(message: json['message']);
}
