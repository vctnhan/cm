import 'package:dio/dio.dart';
import 'api_exceptions.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('[API] ${options.method} ${options.path}');
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data['success'] != true) {
      throw ApiException.fromResponse(response.data);
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    throw ApiException.fromDioError(err);
  }
}
