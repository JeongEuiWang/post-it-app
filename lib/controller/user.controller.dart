import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:post_it/services/user.service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:post_it/utils/token_storage.dart';
import 'package:post_it/models/user.model.dart'
    as user_model; //firebase auth와 User 클래스 충돌 해결을 위한 alias

class UserController extends GetxController {
  final _userService = UserService();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'https://www.googleapis.com/auth/userinfo.email',
    'https://www.googleapis.com/auth/gmail.readonly'
  ]);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TokenStorage _storage = TokenStorage();

  final Rxn<user_model.User> _user = Rxn<user_model.User>();

  void setUser(user_model.User user) {
    _user.value = user;
  }

  user_model.User? get user => _user.value;

  int? get userId => _user.value?.id;

  Future<void> handleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw Exception("Invalid Google User");

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      if (googleAuth.idToken == null) throw Exception("Invalid Id Token");

      final userResponse = await _userService.loginAPI(googleAuth.idToken!);

      setUser(userResponse);

      await _storage.saveAccessToken(googleAuth.accessToken!);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> isSignedIn() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return false;

      final GoogleSignInAccount? googleUser =
          await _googleSignIn.signInSilently();
      if (googleUser == null) return false;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final userResponse = await _userService.loginAPI(googleAuth.idToken!);
      setUser(userResponse);
      await _storage.saveAccessToken(googleAuth.accessToken!);
      return true;
    } catch (e) {
      return false;
    }
    // await Future.delayed(Duration(seconds: 2)); // 스플래시 화면 대기 시간
  }
}
