import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:post_it/constants/Colors.dart';
import 'package:post_it/constants/font.dart';
import 'package:post_it/controller/category.controller.dart';
import 'package:get/get.dart';
import 'package:post_it/controller/user.controller.dart';

class AllArticlesTab extends StatefulWidget {
  const AllArticlesTab({super.key});

  @override
  AllArticlesTabState createState() => AllArticlesTabState();
}

class AllArticlesTabState extends State<AllArticlesTab> {
  final CategoryController _categoryController = Get.find<CategoryController>();
  final UserController _userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  Future<void> _getCategories() async {
    await _categoryController.getCategories(_userController.userId!);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => _categoryController.isLoadingState()
        ? Center(child: CircularProgressIndicator(color: CustomColors.primary))
        : Column(mainAxisSize: MainAxisSize.max, children: [
            CategoryButtons(),
            _categoryController.categories.isEmpty
                ? Column(
                    spacing: 20,
                    children: [
                      EmptyDataViewer(
                        imagePath: 'assets/images/image_empty.svg',
                        title: '카테고리가 비어있어요',
                        description: '먼저 카테고리를 생성해 주세요.',
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(CustomColors.primary),
                        ),
                        onPressed: () {},
                        child: Text('생성하기',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: pretendard,
                                color: CustomColors.white)),
                      ),
                    ],
                  )
                : Text("All categories")
          ]));
  }
}

class EmptyDataViewer extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const EmptyDataViewer({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Center(
          child: Column(children: [
        SvgPicture.asset(imagePath,
            width: constraints.maxWidth * 0.8, fit: BoxFit.cover),
        Text(title,
            style: TextStyle(
                fontSize: 20,
                fontFamily: pretendard,
                fontWeight: FontWeight.w600)),
        Text(description,
            style: TextStyle(
                fontSize: 16,
                fontFamily: pretendard,
                fontWeight: FontWeight.w400))
      ]));
    });
  }
}

class CategoryButtons extends StatefulWidget {
  @override
  CategoryButtonsState createState() => CategoryButtonsState();
}

class CategoryButtonsState extends State<CategoryButtons> {
  final CategoryController _categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 20),
          scrollDirection: Axis.horizontal,
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children:
                  List.generate(_categoryController.categories.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Obx(() => AnimatedContainer(
                      duration: Duration(milliseconds: 150), // 애니메이션 지속 시간
                      curve: Curves.easeInOut, // 애니메이션 곡선
                      decoration: BoxDecoration(
                        color: _categoryController.isSelectedCategory(index)
                            ? CustomColors.primary
                            : CustomColors.white,
                        border: Border.all(
                            width: 1,
                            color: _categoryController.isSelectedCategory(index)
                                ? CustomColors.primary
                                : CustomColors.border),
                        borderRadius:
                            BorderRadius.circular(100), // 선택 여부에 따른 둥근 모서리
                      ),
                      child: TextButton(
                          onPressed: () {
                            _categoryController.onSelectCategory(index);
                          },
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 28),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: AnimatedDefaultTextStyle(
                              duration: Duration(milliseconds: 150),
                              curve: Curves.easeInOut, // 애니메이션 곡선
                              style: TextStyle(
                                  fontSize: 14,
                                  color: _categoryController
                                          .isSelectedCategory(index)
                                      ? CustomColors.white
                                      : CustomColors.black,
                                  fontFamily: pretendard,
                                  fontWeight: FontWeight.w500),
                              child: Text(
                                _categoryController.categories[index].name,
                              ))))),
                );
              })),
        ));
  }
}
