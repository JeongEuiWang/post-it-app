import 'package:post_it/models/user.model.dart';
import 'package:post_it/services/base.service.dart';

class UserService extends BaseService {
  Future<User> loginAPI({required String idToken}) async {
    final response = await post('/user/login', {"idToken": idToken});
    return User.fromJson(response.body);
  }
}
