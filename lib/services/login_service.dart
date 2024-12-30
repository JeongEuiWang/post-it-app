class AuthService {
  static Future<bool> mockLoginCheck() async {
    // 실제 로그인 여부 확인 로직 대체
    return Future.value(false); // true면 로그인 상태, false면 비로그인 상태
  }
}
