import 'package:post_it/models/user.model.dart';
import 'base.service.dart';

class UserService extends BaseService {
  Future<User> loginAPI(String idToken) async {
    final response = await post('/user/login', {"idToken": idToken});
    return User.fromJson(response.body);
  }
}
