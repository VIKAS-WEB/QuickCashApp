// login_api.dart
import 'package:dio/dio.dart';
import '../../../util/apiConstants.dart';
import 'login_model.dart';

class LoginApi {
  final Dio _dio = Dio();

  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}/user/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to login: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
