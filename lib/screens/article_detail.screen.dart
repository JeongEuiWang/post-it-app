import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:post_it/constants/color.dart';
import 'package:post_it/constants/font.dart';
import 'package:post_it/controller/articles.controller.dart';
import 'package:post_it/controller/user.controller.dart';
import 'package:post_it/models/article_detail.model.dart';
import 'package:html/parser.dart' as html_parser;

import 'package:intl/intl.dart';

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

  final ArticleDetail? selectedArticle =
      Get.find<ArticleController>().articleDetail;
  final int? userId = Get.find<UserController>().userId;

  @override
  void initState() {
    if (userId != null) {
      getArticleDetail();
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CenterTextPopAppBar(
          centerText: widget.categoryName,
        ),
        body: Obx(() => (!articleController.isLoadingArticleDetail() &&
                articleController.articleDetail != null)
            ? Container(
                margin: EdgeInsets.only(top: 20.0),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                child: Column(
                  children: [
                    ArticleDetailHeader(),
                    ArticleDetailContent()
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
  ArticleDetailHeader({super.key});

  final ArticleDetail? selectedArticle =
      Get.find<ArticleController>().articleDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(selectedArticle?.date ?? '-',
            style: TextStyle(
                fontSize: 14,
                fontFamily: pretendard,
                color: CustomColors.lightGrey)),
        const SizedBox(height: 10),
        Text(selectedArticle?.title ?? '-',
            style: TextStyle(
                fontSize: 18,
                fontFamily: pretendard,
                fontWeight: FontWeight.w500,
                color: CustomColors.black)),
        const SizedBox(height: 20),
        Divider(height: 1, thickness: 1, color: CustomColors.border)
      ],
    );
  }
}

class ArticleDetailContent extends StatelessWidget {
  ArticleDetailContent({super.key});

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

  String removeSpecificTagsUsingHtmlParser(
      String? html, List<String> tagsToRemove) {
    var document = html_parser.parse(html);

    for (var tag in tagsToRemove) {
      document.getElementsByTagName(tag).forEach((element) {
        element.remove();
      });
    }

    return document.outerHtml;
  }

  @override
  Widget build(BuildContext context) {
    return selectedArticle != null
        ? SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: HtmlWidget(removeSpecificTagsUsingHtmlParser(
                decodeContentToUTF(selectedArticle?.content),
                ['head', 'title'])), // non-nullable value
          )
        : Text("ERror");
  }
}

class CenterTextPopAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String centerText;
  const CenterTextPopAppBar({super.key, required this.centerText});

  @override
  Size get preferredSize => Size.fromHeight(48.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      title: Text(centerText,
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF222222),
              fontFamily: 'Pretendard')),
      centerTitle: true,
    );
  }
}
