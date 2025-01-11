import 'package:get/get.dart';

class BaseService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://localhost:8000';
    super.onInit();
  }

  BaseService() {
    onInit();
  }
}
