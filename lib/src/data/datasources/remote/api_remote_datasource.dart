import 'package:chipmunk/src/data/models/request/base_request.dart';

import '../../network/api_service.dart';
import '../../network/api_endpoints.dart';
import '../../models/request/user_request_model.dart';

class AuthRemoteDataSource {
  final ApiService api;

  AuthRemoteDataSource(this.api);

  Future<String> getUserInfo(BaseRequest rq) async {
    final res = await api.post<String>(
      ApiEndpoints.requestOtp,
      body: rq,
      parser: (json) => json['request_id'],
    );
    return res.data!;
  }

}
