// login_model.dart
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class LoginResponse {
  final String userId;
  final String token;

  LoginResponse({required this.userId, required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      userId: json['user_id'],
      token: json['token'],
    );
  }
}
