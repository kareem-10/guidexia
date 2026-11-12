import 'package:dio/dio.dart';
import 'package:tourist_app/core/helpers/secure_storage_helper.dart';

class ApiInterceptor extends Interceptor {
  final SecureStorageHelper secureStorage;

  ApiInterceptor(this.secureStorage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await secureStorage.getToken();

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }

      handler.next(options);
    } catch (e) {
      handler.reject(DioException(requestOptions: options, error: e));
    }
  }
}
