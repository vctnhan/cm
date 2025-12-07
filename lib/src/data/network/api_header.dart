import 'package:uuid/uuid.dart';

class ApiHeaders {
  static Map<String, String> defaultHeaders({
    String? accessToken,
    required String platform,
    required String deviceId,
  }) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': accessToken != null ? 'Bearer $accessToken' : '',
      'X-Request-ID': const Uuid().v7(),
      'X-Device-ID': deviceId,
      'X-Platform': platform, // ios | android | web | desktop
    };
  }
}
