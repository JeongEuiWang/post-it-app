import 'package:get/get.dart';
import 'package:post_it/utils/token_storage.dart';

mixin TokenManager on GetConnect {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  final TokenStorage _storage = TokenStorage();

  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = 'http://localhost:8000';

    // httpClient.addResponseModifier((request, response) async {
    //   if (response.statusCode == 401) {
    //     final newAccessToken = await _refreshToken();
    //     if (newAccessToken != null) {
    //       request.headers['Authorization'] = 'Bearer $newAccessToken';
    //       return httpClient.request(
    //         request.method,
    //         request.url.toString(),
    //         body: request.bodyBytes,
    //         headers: request.headers,
    //       );
    //     }
    //   }
    //   return response;
    // });
  }
}
