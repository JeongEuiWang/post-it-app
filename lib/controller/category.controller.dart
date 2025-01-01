import 'package:get/get.dart';
import 'package:post_it/models/category.model.dart';
import 'package:post_it/services/category.service.dart';

class CategoryController extends GetxController {
  var isLoading = true.obs;
  var categories = <Category>[].obs; // 필터 리스트
  var selectedCategoryIndex = 0.obs; // 선택된 필터의 인덱스

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  // 필터 데이터 가져오기
  void getCategories() async {
    try {
      var response = await CategoryService.getCategoriesAPI();
      categories.value = response;
    } catch (e) {
      print("Error fetching filters: $e");
    } finally {
      isLoading.value = false;
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
