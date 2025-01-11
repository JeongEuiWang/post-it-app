import 'package:get/get.dart';
import 'package:post_it/models/favorite.model.dart';
import 'package:post_it/services/favorite.service.dart';

class FavoriteController extends GetxController {
  // service
  final FavoriteService favoriteService = FavoriteService();

  // state
  final isLoadCheckFavorite = true.obs;

  final RxBool isFavorite = RxBool(false);

  // method
  Future<bool> checkIsFavorite({required String messageId}) async {
    isLoadCheckFavorite.value = true;
    try {
      final result =
          await favoriteService.checkIsFavoriteAPI(messageId: messageId);
      isFavorite.value = result;
      return result;
    } catch (e) {
      isFavorite.value = false;
      return false;
    } finally {
      isLoadCheckFavorite.value = false;
    }
  }

  Future<void> registerFavorite(
      {required int? userId,
      required int categoryId,
      required String messageId}) async {
    if (userId == null) return;
    try {
      await favoriteService.createFavoriteAPI(
          userId: userId, categoryId: categoryId, messageId: messageId);
      isFavorite.value = true;
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteFavorite(
      {required int? userId, required String messageId}) async {
    if (userId == null) return;
    try {
      await favoriteService.deleteFavoriteAPI(
          userId: userId, messageId: messageId);
      isFavorite.value = false;
    } catch (e) {
      print(e);
    }
  }

  bool isLoadingCheckFavorite() {
    return isLoadCheckFavorite.value;
  }
}
