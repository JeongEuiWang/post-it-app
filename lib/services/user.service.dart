import 'package:post_it/models/user.model.dart';
import 'package:post_it/services/base.service.dart';

class UserService extends BaseService {
  Future<User> loginAPI({required String idToken}) async {
    print("idToken $idToken");
    final response = await post('/user/login', {"idToken": idToken});
    print("response.body: ${response.body}");
    return User.fromJson(response.body);
  }
}
