import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_it/controller/category_controller.dart';
import 'package:post_it/widgets/appBars/home_app_bar.dart';
import 'package:post_it/widgets/app_bar_widget';
import 'package:post_it/widgets/category_buttons_widget.dart';
import 'package:post_it/widgets/tab_content_widget.dart';

class HomeScreen extends StatelessWidget {
  final CategoryController _categoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(),
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: Text('서브 페이지로 이동'),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('기본 AppBar'),
  //     ),
  //     body: Obx(() {
  //       if (_categoryController.isLoadingState()) {
  //         return Center(child: Text("loading"));
  //       }
  //       return ListView.builder(
  //         itemCount: _categoryController.categories.length,
  //         itemBuilder: (context, index) {
  //           return ListTile(
  //             title: Text(_categoryController.categories[index].name), // 데이터 표시
  //           );
  //         },
  //       );
  //     }),
  //   );
}
