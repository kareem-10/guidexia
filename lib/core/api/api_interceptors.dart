import 'package:dio/dio.dart';
import 'package:tourist_app/core/api/end_ponits.dart';
import 'package:tourist_app/core/helpers/cache_helper.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = CacheHelper().getData(key: ApiKey.token);

    if (token != null && token.toString().isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}
