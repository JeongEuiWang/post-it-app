import 'package:get/get_connect/http/src/response/response.dart';
import 'package:post_it/models/article.model.dart';
import 'package:post_it/models/article_detail.model.dart';
import 'package:post_it/services/auth.service.dart';
import 'package:post_it/utils/token_storage.dart';

class ArticleService extends AuthService {
  final TokenStorage _storage = TokenStorage();

  Future<List<Article>> getArticlesAPI(
      {required int userId, required int categoryId}) async {
    final token = await _storage.getAccessToken();

    final Response response = await get(
        headers: {"Authorization": 'Bearer $token'},
        '/article?userId=$userId&categoryId=$categoryId');
    List<dynamic> body = response.body;

    return body.map((json) => Article.fromJson(json)).toList();
  }

  Future<ArticleDetail> getArticleDetailAPI(
      {required int userId,
      required String messageId,
      required int categoryId}) async {
    final token = await _storage.getAccessToken();

    final Response response = await get(
        headers: {"Authorization": 'Bearer $token'},
        '/article/$messageId?userId=$userId&categoryId=$categoryId');
    print(response);

    return ArticleDetail.fromJson(response.body);
  }
}
