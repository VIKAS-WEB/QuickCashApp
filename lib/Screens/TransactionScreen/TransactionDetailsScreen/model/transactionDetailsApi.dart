import 'package:dio/dio.dart';
import 'package:quickcash/Screens/TransactionScreen/TransactionDetailsScreen/model/transactionDetailsModel.dart';
import 'package:quickcash/util/auth_manager.dart';
import '../../../../util/apiConstants.dart';

class TransactionDetailsListApi {
  final Dio _dio = Dio();

  TransactionDetailsListApi() {
    _dio.options.baseUrl = ApiConstants.baseUrl;


    /*_dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
    ));*/
  }

  Future<TransactionDetailsListResponse> transactionDetailsListApi(String trxID) async {
    try {
      final response = await _dio.get(
        '/transaction/$trxID',
        options: Options(headers: {
          'Authorization': 'Bearer ${AuthManager.getToken()}',
          'Accept': 'application/json',
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return TransactionDetailsListResponse.fromJson(response.data);
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
