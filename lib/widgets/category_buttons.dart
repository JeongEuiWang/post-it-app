import 'package:flutter/material.dart';
import 'package:post_it/constants/color.dart';
import 'package:post_it/constants/font.dart';
import 'package:post_it/controller/category.controller.dart';
import 'package:get/get.dart';

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
