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

    httpClient.addResponseModifier((request, response) async {
      if (response.statusCode == 401) {
        final newAccessToken = await _refreshToken();
        if (newAccessToken != null) {
          request.headers['Authorization'] = 'Bearer $newAccessToken';
          return httpClient.request(
            request.method,
            request.url.toString(),
            body: request.bodyBytes,
            headers: request.headers,
          );
        }
      }
      return response;
    });
  }

  Future<String?> _refreshToken() async {
    final refreshToken = await _storage.getRefreshToken();
    if (refreshToken == null) return null;

    final response = await post(
      '/reissue',
      {},
      headers: {
        'Cookie': 'refresh=$refreshToken',
      },
    );

    if (response.statusCode == 200) {
      String? newRefreshToken = response.headers?['set-cookie'];
      String? accessToken = response.headers?['Authorization'];

      if (accessToken != null && newRefreshToken != null) {
        await _storage.saveAccessToken(accessToken);
        await _storage.saveAccessToken(refreshToken);
        return accessToken;
      }
    }
    return null;
  }
}
