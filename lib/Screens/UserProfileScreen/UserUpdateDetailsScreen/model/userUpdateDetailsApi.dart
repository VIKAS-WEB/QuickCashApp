import 'package:dio/dio.dart';
import 'package:quickcash/Screens/UserProfileScreen/UserUpdateDetailsScreen/model/userUpdateDetailsModel.dart';
import 'package:quickcash/util/auth_manager.dart';
import '../../../../util/apiConstants.dart';

class UserProfileUpdateApi {
  final Dio _dio = Dio();

  UserProfileUpdateApi() {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.options.headers['Authorization'] = 'Bearer ${AuthManager.getToken()}'; // Ensure token is prefixed with "Bearer"
  }


  Future<UserProfileUpdateResponse> userProfileUpdate(UserProfileUpdateRequest request) async {
    try {
      final response = await _dio.patch(
        '/user/update-profile',
        data: request.toJson(),
      );

      // Check for a successful response
      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserProfileUpdateResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to update profile: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }


 /* Future<UserProfileUpdateResponse> userProfileUpdate({
    required String name,
    required String email,
    required String mobile,
    required String address,
    required String country,
    required String state,
    required String city,
    required String postalCode,
    required String title,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'name': name,
        'email': email,
        'phone': mobile,
        'address': address,
        'country': country,
        'state': state,
        'city': city,
        'postalCode': postalCode,
        'title': title,
      });

      // Make the POST request
      final response = await _dio.post(
        '/user/update-profile',
        data: formData,
      );

      // Check for a successful response
      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserProfileUpdateResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to update profile: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }*/
}
