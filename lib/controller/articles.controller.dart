import 'package:get/get.dart';
import 'package:post_it/models/article.model.dart';
import 'package:post_it/models/article_detail.model.dart';
import 'package:post_it/services/article.service.dart';

class ArticleController extends GetxController {
  // service
  final ArticleService articleService = ArticleService();

  // state
  final isLoadArticleList = true.obs;
  final isLoadArticleDetail = true.obs;

  final RxList<Article> articles = RxList<Article>();
  final Rxn<ArticleDetail> selectedArticle = Rxn<ArticleDetail>();

  ArticleDetail? get articleDetail => selectedArticle.value;

  // method
  Future<void> getCategoryArticles(
      {required int? userId, required int categoryId}) async {
    isLoadArticleList.value = true;
    if (userId == null) {
      throw Exception("Error: userId is null");
    }
    try {
      List<Article> result = await articleService.getArticlesAPI(
          userId: userId, categoryId: categoryId);
      articles.value = result;
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoadArticleList.value = false;
    }
  }

  Future<void> getArticleDetail(
      {required int? userId,
      required int categoryId,
      required String messageId}) async {
    isLoadArticleDetail.value = true;
    if (userId == null) {
      throw Exception("Error: userId is null");
    }
    try {
      ArticleDetail result = await articleService.getArticleDetailAPI(
          userId: userId, categoryId: categoryId, messageId: messageId);
      selectedArticle.value = result;

    } catch (e) {
      throw Exception(e);
    } finally {
      isLoadArticleDetail.value = false;
    }
  }

   bool isLoadingArticleDetail() {
    return isLoadArticleDetail.value;
  }

  bool isLoadingArticleList() {
    return isLoadArticleList.value;
  }
}
