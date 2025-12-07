import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String code;
  final String message;
  final List<ApiErrorDetail> details;

  ApiException({
    required this.code,
    required this.message,
    required this.details,
  });

  factory ApiException.fromResponse(Map<String, dynamic> json) {
    final error = json['error'];
    return ApiException(
      code: error['code'],
      message: error['message'],
      details: (error['details'] as List? ?? [])
          .map((e) => ApiErrorDetail.fromJson(e))
          .toList(),
    );
  }

  factory ApiException.fromDioError(DioException e) {
    return ApiException(
      code: e.type.name,
      message: e.message ?? 'Unknown error',
      details: [],
    );
  }
}

class ApiErrorDetail {
  final String field;
  final String message;

  ApiErrorDetail({
    required this.field,
    required this.message,
  });

  factory ApiErrorDetail.fromJson(Map<String, dynamic> json) {
    return ApiErrorDetail(
      field: json['field'],
      message: json['message'],
    );
  }
}
