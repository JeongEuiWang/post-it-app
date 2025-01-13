import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:post_it/constants/color.dart';
import 'package:post_it/constants/font.dart';
import 'package:post_it/controller/articles.controller.dart';
import 'package:post_it/controller/favorite.controller.dart';
import 'package:post_it/controller/user.controller.dart';
import 'package:post_it/models/article_detail.model.dart';
import 'package:post_it/widgets/appBars/center_text_pop_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailScreen extends StatefulWidget {
  final int categoryId;
  final String messageId;
  final String categoryName;
  const ArticleDetailScreen(
      {super.key,
      required this.categoryId,
      required this.messageId,
      required this.categoryName});

  @override
  ArticleDetailScreenState createState() => ArticleDetailScreenState();
}

class ArticleDetailScreenState extends State<ArticleDetailScreen> {
  final ArticleController articleController = Get.find<ArticleController>();
  final FavoriteController favoriteController = Get.find<FavoriteController>();
  late final WebViewController _controller;

  final ArticleDetail? selectedArticle =
      Get.find<ArticleController>().articleDetail;
  final int? userId = Get.find<UserController>().userId;

  @override
  void initState() {
    if (userId != null) {
      getArticleDetail();
      checkIsFavorite();
    }
    _controller = WebViewController();
    // ..setJavaScriptMode(JavaScriptMode.unrestricted) // JavaScript 활성화
    super.initState();
  }

  Future<void> getArticleDetail() async {
    if (userId != null) {
      await articleController.getArticleDetail(
          userId: userId,
          categoryId: widget.categoryId,
          messageId: widget.messageId);
    }
  }

  Future<void> checkIsFavorite() async {
    await favoriteController.checkIsFavorite(messageId: widget.messageId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CenterTextPopAppBar(
          centerText: widget.categoryName,
        ),
        body: Obx(() => (!articleController.isLoadingArticleDetail() &&
                articleController.articleDetail != null &&
                !favoriteController.isLoadingCheckFavorite())
            ? Container(
                margin: EdgeInsets.only(top: 16.0),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                child: Column(
                  children: [
                    ArticleDetailHeader(
                      messageId: widget.messageId,
                      categoryId: widget.categoryId,
                    ),
                    Expanded(
                        child: ArticleDetailContent(
                            webviewController: _controller))
                    // Expanded(child: Text(articleController.selectedArticle.date)),
                  ],
                ))
            : Column(
                children: [
                  Expanded(
                      child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(CustomColors.primary),
                    ),
                  ))
                ],
              )));
  }
}

class ArticleDetailHeader extends StatelessWidget {
  final int categoryId;
  final String messageId;
  ArticleDetailHeader(
      {super.key, required this.categoryId, required this.messageId});

  final ArticleDetail? selectedArticle =
      Get.find<ArticleController>().articleDetail;
  final FavoriteController favoriteController = Get.find<FavoriteController>();
  final RxBool isFavorite = Get.find<FavoriteController>().isFavorite;
  final int? userId = Get.find<UserController>().userId;

  Future<void> registerFavorite() async {
    if (userId != null) {
      await favoriteController.registerFavorite(
          userId: userId, categoryId: categoryId, messageId: messageId);
    }
  }

  Future<void> deleteFavorite() async {
    if (userId != null) {
      await favoriteController.deleteFavorite(
          userId: userId, messageId: messageId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(selectedArticle?.date ?? '-',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: pretendard,
                          color: CustomColors.lightGrey)),
                  const SizedBox(height: 4),
                  Text(selectedArticle?.title ?? '-',
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: pretendard,
                          fontWeight: FontWeight.w500,
                          color: CustomColors.black)),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Obx(() => isFavorite.value
                ? GestureDetector(
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        content: const Text('즐겨찾기를 해제하시겠어요?'),
                        contentTextStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontFamily: pretendard,
                            color: CustomColors.black),
                        actions: <Widget>[
                          SizedBox(
                            height: 24,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero),
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('취소'),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero),
                                  onPressed: () {
                                    deleteFavorite();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('해제'),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/images/icon_favorite.svg',
                      width: 20,
                      height: 20,
                    ),
                  )
                : GestureDetector(
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        content: const Text('즐겨찾기에 등록하시겠어요?'),
                        contentTextStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontFamily: pretendard,
                            color: CustomColors.black),
                        actions: <Widget>[
                          SizedBox(
                            height: 24,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero),
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('취소'),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero),
                                  onPressed: () {
                                    registerFavorite();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('등록'),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/images/icon_not_favorite.svg',
                      width: 20,
                      height: 20,
                    ),
                  ))
          ],
        ),
        Divider(height: 1, thickness: 0.5, color: CustomColors.border)
      ],
    );
  }
}

class ArticleDetailContent extends StatelessWidget {
  ArticleDetailContent({super.key, required this.webviewController});
  final WebViewController webviewController;

  final ArticleDetail? selectedArticle =
      Get.find<ArticleController>().articleDetail;

  String? decodeContentToUTF(String? content) {
    if (content == null) return null;
    try {
      List<int> decodedBytes = base64Decode(content);
      return utf8.decode(decodedBytes);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final decodedContent = decodeContentToUTF(selectedArticle?.content) ?? "";

    if (decodedContent.isEmpty) {
      return Text("Error: No content to display");
    }
    return WebViewWidget(
      controller: webviewController
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.dataFromString(
          decodedContent,
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8'),
        )),
    );
  }
}
