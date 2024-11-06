import 'package:dio/dio.dart';
import '../../../util/apiConstants.dart';
import 'forgot_password_model.dart';

class ForgotPasswordApi {
  final Dio _dio = Dio();

  Future<ForgotPasswordResponse> forgotPassword(String email,) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}/user/forget-password',
        data: {
          'email': email,
        },
      );

      // Check for both 200 and 201 statuses
      if (response.statusCode == 200 || response.statusCode == 201) {
        //print("Response data: ${response.data}"); // Debugging line
        return ForgotPasswordResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to register: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
