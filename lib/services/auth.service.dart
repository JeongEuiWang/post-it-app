import 'package:post_it/services/base.service.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:post_it/utils/token_storage.dart';

class AuthService extends BaseService {
  final TokenStorage _storage = TokenStorage();
  @override
  void onInit() {
    super.onInit();
    httpClient.addRequestModifier<void>((Request request) async {
      final token = await _storage.getAccessToken();

      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      return request;
    });
  }
}
