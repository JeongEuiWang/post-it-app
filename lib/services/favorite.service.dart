import 'package:get/get_connect/http/src/response/response.dart';
import 'package:post_it/models/favorite.model.dart';
import 'package:post_it/services/base.service.dart';

class FavoriteService extends BaseService {
  Future<bool> checkIsFavoriteAPI({required String messageId}) async {
    final Response response = await get('/favorite/check?messageId=$messageId');
    final body = response.body;
    final isFavorite = body["is_favorite"];
    return isFavorite;
  }

  Future<Favorite> createFavoriteAPI(
      {required int userId,
      required int categoryId,
      required String messageId}) async {
    final Response response = await post('/favorite',
        {'userId': userId, 'categoryId': categoryId, 'messageId': messageId});
    return Favorite.fromJson(response.body);
  }

  Future<bool> deleteFavoriteAPI(
      {required int userId, required String messageId}) async {
    final Response response =
        await delete('/favorite?userId=$userId&messageId=$messageId');
    return response.body["success"];
  }
}
