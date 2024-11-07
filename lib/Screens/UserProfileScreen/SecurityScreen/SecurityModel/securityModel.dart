
class SecurityRequest {
  final String email;
  final String name;

  SecurityRequest({required this.email, required this.name});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
    };
  }
}

class SecurityResponse {
  final String? message;
  final int? otp;


  SecurityResponse({this.message, this.otp});

  factory SecurityResponse.fromJson(Map<String, dynamic> json) {
    return SecurityResponse(
      message: json['message'] as String?,
      otp: json['data'] as int?,
    );
  }
}


