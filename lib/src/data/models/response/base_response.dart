class BaseResponse<T> {
  final bool success;
  final T? data;
  final Pagination? pagination;
  final ApiError? error; // ✅ thêm field error

  BaseResponse({required this.success, this.data, this.pagination, this.error});

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return BaseResponse(
      success: json['success'] ?? false,
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      pagination: json['meta']?['pagination'] != null
          ? Pagination.fromJson(json['meta']['pagination'])
          : null,
      error: json['error'] != null ? ApiError.fromJson(json['error']) : null,
    );
  }

  bool get isSuccess => success == true;

  bool get hasError => error != null;
}

class Pagination {
  final int page;
  final int limit;
  final int total;
  final bool hasMore;

  Pagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.hasMore,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      hasMore: json['has_more'],
    );
  }
}

class ApiError {
  final String code;
  final String message;
  final List<ApiErrorDetail> details;

  ApiError({required this.code, required this.message, required this.details});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      code: json['code'] ?? '',
      message: json['message'] ?? 'Unknown error',
      details: (json['details'] as List? ?? [])
          .map((e) => ApiErrorDetail.fromJson(e))
          .toList(),
    );
  }
}

class ApiErrorDetail {
  final String field;
  final String message;

  ApiErrorDetail({required this.field, required this.message});

  factory ApiErrorDetail.fromJson(Map<String, dynamic> json) {
    return ApiErrorDetail(
      field: json['field'] ?? '',
      message: json['message'] ?? '',
    );
  }
}
