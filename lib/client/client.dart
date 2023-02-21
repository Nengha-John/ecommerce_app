import 'package:dio/dio.dart' as dio;
import 'package:ecommerce_app/config/api.config.dart';

class Client {
  // Custom HTTP Client to handle all requests to backend
  var client = dio.Dio(dio.BaseOptions(
      baseUrl: ApiConfig.BASE_API_URL,
      connectTimeout: const Duration(seconds: 60),
      receiveDataWhenStatusError: true,
      receiveTimeout: const Duration(seconds: 60)));

  Future<dio.Response> get(String path,
      [Map<String, dynamic>? query, String? auth]) async {
    try {
      return await client.get(path,
          queryParameters: query ?? {},
          options: dio.Options(headers: {'Authorization': auth}));
    } on dio.DioError catch (e) {
      String message = '';
      // Check if error originate from server or problems in connectivity
      if (e.response!.data != null) {
        message = e.response!.data['message'];
      } else {
        message = e.error.toString();
      }
      return dio.Response(
          statusCode: 400,
          requestOptions: e.requestOptions,
          data: {'success': false, 'message': message});
    }
  }
}
