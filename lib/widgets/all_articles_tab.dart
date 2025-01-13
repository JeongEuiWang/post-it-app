import 'package:flutter/material.dart';
import 'package:post_it/constants/color.dart';
import 'package:post_it/constants/font.dart';
import 'package:post_it/controller/articles.controller.dart';
import 'package:post_it/controller/category.controller.dart';
import 'package:get/get.dart';
import 'package:post_it/controller/user.controller.dart';
import 'package:post_it/models/category.model.dart';
import 'package:post_it/screens/article_detail.screen.dart';
import 'package:post_it/widgets/category_buttons.dart';
import 'package:post_it/widgets/create_category_modal.dart';
import 'package:post_it/widgets/empty_data_viewer.dart';

class AllArticlesTab extends StatefulWidget {
  const AllArticlesTab({super.key});

  @override
  AllArticlesTabState createState() => AllArticlesTabState();
}

class AllArticlesTabState extends State<AllArticlesTab>
    with SingleTickerProviderStateMixin {
  final CategoryController categoryController = Get.find<CategoryController>();
  final int? _userId = Get.find<UserController>().userId;
  late AnimationController _animationController;

  @override
  void initState() {
    if (_userId != null && categoryController.categories.isEmpty) {
      _getCategories(_userId);
    }
    _animationController = BottomSheet.createAnimationController(this);
    _animationController.duration = Duration(milliseconds: 300);

    super.initState();
  }

  Future<void> _getCategories(int? userId) async {
    if (_userId != null) {
      await categoryController.getCategories(userId: _userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => categoryController.isLoadingState()
        ? SizedBox.shrink()
        : Column(mainAxisSize: MainAxisSize.max, children: [
            CategoryButtons(),
            Expanded(
                child: categoryController.categories.isEmpty
                    ? Column(
                        spacing: 20,
                        children: [
                          EmptyDataViewer(
                            imagePath: 'assets/images/image_empty.svg',
                            title: '카테고리가 비어있어요',
                            description: '먼저 카테고리를 생성해 주세요.',
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(170, 40),
                                backgroundColor: CustomColors.primary),
                            onPressed: () {
                              CreateCategoryModal.show(context,
                                  animationController: _animationController);
                            },
                            child: Text('생성하기',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: pretendard,
                                    color: CustomColors.white)),
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: AllArticles()))
          ]));
  }
}

class AllArticles extends StatefulWidget {
  const AllArticles({super.key});

  @override
  AllArticlesState createState() => AllArticlesState();
}

class AllArticlesState extends State<AllArticles> {
  final ArticleController articleController = Get.find<ArticleController>();
  final RxInt selectedCategoryIndex =
      Get.find<CategoryController>().selectedCategoryIndex;
  final int? userId = Get.find<UserController>().userId;
  final List<Category> categories = Get.find<CategoryController>().categories;

  @override
  void initState() {
    _getCategoryArticles(userId, categories[selectedCategoryIndex.value].id);
    ever<int>(selectedCategoryIndex, (index) {
      _getCategoryArticles(userId, categories[index].id);
    });
    super.initState();
  }

  Future<void> _getCategoryArticles(int? userId, int categoryId) async {
    if (userId != null && categories.isNotEmpty) {
      await articleController.getCategoryArticles(
          userId: userId, categoryId: categoryId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => articleController.isLoadingArticleList()
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(CustomColors.primary),
            ),
          )
        : articleController.articles.isEmpty
            ? EmptyDataViewer(
                imagePath: 'assets/images/image_empty_article.svg',
                title: '아티클이 존재하지 않아요.',
                description: '혹시 설정한 이메일이 잘못 기입되진 않았는지\n확인해주세요.',
              )
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    children: List.generate(articleController.articles.length,
                        (index) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ArticleDetailScreen(
                                    categoryId:
                                        categories[selectedCategoryIndex.value]
                                            .id,
                                    messageId: articleController
                                        .articles[index].messageId,
                                    categoryName:
                                        categories[selectedCategoryIndex.value]
                                            .name)),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 4,
                              children: [
                                Text(articleController.articles[index].date,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: pretendard,
                                        fontWeight: FontWeight.w400,
                                        color: CustomColors.grey)),
                                Text(articleController.articles[index].title,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: pretendard,
                                        fontWeight: FontWeight.w600,
                                        color: CustomColors.black)),
                                Text(articleController.articles[index].snippet,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: pretendard,
                                        fontWeight: FontWeight.w400,
                                        color: CustomColors.grey)),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Divider(
                              // 구분선
                              color: CustomColors.border, // 색상
                              thickness: 0.5, // 두께
                            ),
                          ],
                        ),
                      ));
                }))));
  }
}
