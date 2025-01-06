import 'package:get/get.dart';
import 'package:post_it/utils/token_manager.dart';

class BaseService extends GetConnect with TokenManager {
  BaseService() {
    onInit();
  }
}
