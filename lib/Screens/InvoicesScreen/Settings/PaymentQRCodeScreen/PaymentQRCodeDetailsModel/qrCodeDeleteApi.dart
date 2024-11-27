import 'package:dio/dio.dart';
import 'package:quickcash/util/auth_manager.dart';
import '../../../../../util/apiConstants.dart';
import '../../../ClientsScreen/ClientsScreen/deleteClientModel/deleteClientModel.dart';

class QrCodeDeleteApi {
  final Dio _dio = Dio();

  QrCodeDeleteApi() {
    _dio.options.baseUrl = ApiConstants.baseUrl;


    /*_dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
    ));*/
  }

  Future<DeleteClientResponse> qrCodeDeleteApi(String qrCodeId) async {
    try {
      final response = await _dio.delete(
        '/qrcode/delete/$qrCodeId',
        options: Options(headers: {
          'Authorization': 'Bearer ${AuthManager.getToken()}',
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return DeleteClientResponse.fromJson(response.data);
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
