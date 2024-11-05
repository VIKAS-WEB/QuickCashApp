// login_model.dart
class SignUpRequest {
  final String name;
  final String email;
  final String password;
  final String country;
  final String referralCode;

  SignUpRequest({required this.name, required this.email, required this.password, required this.country, required this.referralCode});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'country': country,
      'referalCode': referralCode,
    };
  }
}

class SignUpResponse {
  final String? userId;
  final String? token;

  SignUpResponse({this.userId, this.token});

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      userId: json['data']?['_id'] as String?,  // Accessing _id inside data
      token: json['token'] as String?,
    );
  }
}


