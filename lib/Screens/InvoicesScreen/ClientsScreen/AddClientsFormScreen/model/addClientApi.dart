import 'package:dio/dio.dart';
import 'package:quickcash/util/auth_manager.dart';
import '../../../../../util/apiConstants.dart';
import 'addClientModel.dart';

class AddClientApi {
  final Dio _dio = Dio();

  AddClientApi() {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.options.headers['Authorization'] = 'Bearer ${AuthManager.getToken()}';

    /*_dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
    ));*/
  }


  Future<AddClientResponse> addClient(AddClientRequest request) async {
    try {
      final response = await _dio.post(
        '/client/add',
        data: request.toJson(),
      );

      // Check for a successful response
      if (response.statusCode == 200 || response.statusCode == 201) {
        return AddClientResponse.fromJson(response.data);
      }else if (response.statusCode == 401){
        return AddClientResponse.fromJson(response.data);
      }else {
        throw Exception('Failed to add Client: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
