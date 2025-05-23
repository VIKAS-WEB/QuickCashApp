import 'package:dio/dio.dart';
import 'package:quickcash/util/auth_manager.dart';
import '../../../../../util/apiConstants.dart';
import 'manualInvoiceModel.dart';

class ManualInvoicesApi {
  final Dio _dio = Dio();

  ManualInvoicesApi() {
    _dio.options.baseUrl = ApiConstants.baseUrl;


     /*_dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
    ));*/
  }

  Future<ManualInvoicesResponse> manualInvoiceApi() async {
    try {
      final response = await _dio.get(
        '/manualPayment/list',
        options: Options(headers: {
          'Authorization': 'Bearer ${AuthManager.getToken()}',
          'Accept': 'application/json',
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ManualInvoicesResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch data: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
