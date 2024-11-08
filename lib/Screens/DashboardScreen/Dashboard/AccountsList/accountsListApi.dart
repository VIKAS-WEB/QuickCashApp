import 'package:dio/dio.dart';
import 'package:quickcash/util/auth_manager.dart';
import '../../../../util/apiConstants.dart';
import 'accountsListModel.dart';


class AccountsListApi {
  final Dio _dio = Dio();

  AccountsListApi() {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.options.headers['Authorization'] = AuthManager.getToken();
  }

  Future<AccountListResponse> transactionListApi() async {
    try {
      final response = await _dio.get(
        'account/list/${AuthManager.getUserId()}',
      );

      // Check if the response status is successful
      if (response.statusCode == 200 || response.statusCode == 201) {
        return AccountListResponse.fromJson(response.data); // Parse the response data
      } else {
        throw Exception('Failed to fetch data: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      // Catch Dio-specific errors
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    } catch (e) {
      // Catch any other unexpected errors
      throw Exception('Unexpected error: $e');
    }
  }
}
