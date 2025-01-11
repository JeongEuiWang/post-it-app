import 'package:get/get_connect/http/src/response/response.dart';
import 'package:post_it/models/category.model.dart';
import 'package:post_it/services/base.service.dart';

class CategoryService extends BaseService {
  Future<List<Category>> getCategoriesAPI(int userId) async {
    final Response response = await get('/category/categories?userId=$userId');
    List<dynamic> body = response.body; // 서버에서 배열 반환 시 타입 체킹 해야함
    if (body.isEmpty) {
      return [];
    }

    return body.map((json) => Category.fromJson(json)).toList();
  }

  Future<Category> createCategoryAPI(
      int userId, String name, String fromEmail) async {
    final Response response = await post('/category', {
      'userId': userId,
      'name': name,
      'fromEmail': fromEmail,
    });
    return Category.fromJson(response.body);
  }
}
