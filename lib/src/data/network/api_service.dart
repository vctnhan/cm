import 'package:dio/dio.dart';
import 'api_client.dart';
import '../../data/models/response/base_response.dart';
import '../models/request/base_request.dart';

class ApiService {
  final ApiClient _client;

  ApiService(this._client);

  // ====== GET ======
  Future<BaseResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
    required T Function(dynamic json) parser,
  }) async {
    final response = await _client.get(path, query: query);
    return BaseResponse.fromJson(response.data, parser);
  }

  // ====== POST ======
  Future<BaseResponse<T>> post<T>(
    String path, {
    required BaseRequest body,
    required T Function(dynamic json) parser,
  }) async {
    final response = await _client.post(path, body: body.toJson());
    return BaseResponse.fromJson(response.data, parser);
  }

  // ====== PATCH ======
  Future<BaseResponse<T>> patch<T>(
    String path, {
    required BaseRequest body,
    required T Function(dynamic json) parser,
  }) async {
    final response = await _client.patch(path, body: body.toJson());
    return BaseResponse.fromJson(response.data, parser);
  }

  // ====== DELETE ======
  Future<BaseResponse<void>> delete(String path) async {
    final response = await _client.delete(path);
    return BaseResponse.fromJson(response.data, (_) => null);
  }
}
