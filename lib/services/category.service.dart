import 'package:get/get_connect/http/src/response/response.dart';
import 'package:post_it/models/category.model.dart';
import 'auth.service.dart';

class CategoryService extends AuthService {
  Future<List<Category>> getCategoriesAPI(int userId) async {
    final Response response = await get('/category/categories?userId=$userId');
    if (response.body.isEmpty) {
      return [];
    }
    return response.body.map((json) => Category.fromJson(json)).toList();
  }
}
