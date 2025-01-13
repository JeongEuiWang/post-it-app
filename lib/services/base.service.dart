import 'package:get/get.dart';

class BaseService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://localhost:8000';
    httpClient.timeout = Duration(seconds: 60);
    super.onInit();
  }

  BaseService() {
    onInit();
  }
}
