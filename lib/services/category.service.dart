import 'package:post_it/models/category.model.dart';
import 'package:post_it/utils/api_client.dart';

class CategoryService {
  final ApiClient apiClient;

  CategoryService({required this.apiClient});

  static Future<List<Category>> getCategoriesAPI() async {
    final dummy = [
      {"id": 1, "name": "Reddit"},
      {"id": 2, "name": "Korea FE Article"},
      {"id": 3, "name": "코드잇"},
      {"id": 4, "name": "아"},
      {"id": 5, "name": "어어어어어어어어"}
    ];
    // final response = await apiClient.get('/users/$userId');
    return dummy.map((json) => Category.fromJson(json)).toList();
  }
}
