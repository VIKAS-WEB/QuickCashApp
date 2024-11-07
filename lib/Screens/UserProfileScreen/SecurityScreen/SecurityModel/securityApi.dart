// login_api.dart
import 'package:dio/dio.dart';
import 'package:quickcash/Screens/UserProfileScreen/SecurityScreen/SecurityModel/securityModel.dart';

import '../../../../util/apiConstants.dart';
import '../../../../util/auth_manager.dart';


class SecurityApi {
  final Dio _dio = Dio();

  SecurityApi() {
    // Setting base options for Dio
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.options.headers['Authorization'] = AuthManager.getToken();
  }

  Future<SecurityResponse> security(String email, String name) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}/user/send-email',
        data: {
          'email': email,
          'name': name,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return SecurityResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to authenticate user: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
