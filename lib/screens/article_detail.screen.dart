import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:post_it/controller/articles.controller.dart';
import 'package:post_it/controller/user.controller.dart';

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
        appBar: CustomAppBar(
          centerText: widget.categoryName,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 20.0),
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
          child: Column(
            children: [
              Expanded(child: Text("asdasd")),
            ],
          ),
        ));
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String centerText;
  const CustomAppBar({super.key, required this.centerText});

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
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
              fontFamily: 'Pretendard')),
      centerTitle: true,
    );
  }
}
