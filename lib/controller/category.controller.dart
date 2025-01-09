import 'package:get/get.dart';
import 'package:post_it/models/category.model.dart';
import 'package:post_it/services/category.service.dart';

class CategoryController extends GetxController {
  var isLoading = true.obs;
  final RxList<Category> _categories = RxList<Category>(); // 필터 리스트
  var selectedCategoryIndex = 0.obs; // 선택된 필터의 인덱스
  final _categorySerrvice = CategoryService();

  List<Category> get categories => _categories;

  // 필터 데이터 가져오기
  Future<void> getCategories({required int? userId}) async {
    isLoading.value = true;
    if (userId == null) {
      throw Exception("Error: userId is null");
    }
    try {
      final response = await _categorySerrvice.getCategoriesAPI(userId);
      _categories.value = response;
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<Category> createCategory(
      {required int userId,
      required String name,
      required String fromEmail}) async {
    try {
      final result =
          await _categorySerrvice.createCategoryAPI(userId, name, fromEmail);
      return result;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  bool isLoadingState() {
    return isLoading.value;
  }

  // 필터 선택 변경
  void onSelectCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  bool isSelectedCategory(int index) {
    return selectedCategoryIndex.value == index;
  }
}
