import 'package:dio/dio.dart';
import 'api_config.dart';
import 'api_header.dart';
import 'api_interceptors.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: const Duration(milliseconds: ApiConfig.connectTimeout),
        receiveTimeout: const Duration(milliseconds: ApiConfig.receiveTimeout),
      ),
    );

    _dio.interceptors.add(ApiInterceptors());
  }

  void updateHeaders({
    String? token,
    required String platform,
    required String deviceId,
  }) {
    _dio.options.headers = ApiHeaders.defaultHeaders(
      accessToken: token,
      platform: platform,
      deviceId: deviceId,
    );
  }

  Future<Response> get(String path, {Map<String, dynamic>? query}) {
    return _dio.get(path, queryParameters: query);
  }

  Future<Response> post(String path, {dynamic body}) {
    return _dio.post(path, data: body);
  }

  Future<Response> patch(String path, {dynamic body}) {
    return _dio.patch(path, data: body);
  }

  Future<Response> delete(String path) {
    return _dio.delete(path);
  }
}
