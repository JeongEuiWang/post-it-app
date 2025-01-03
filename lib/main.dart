import 'package:flutter/material.dart';
import 'package:post_it/controller/category.controller.dart';
import 'package:post_it/screens/splash.screen.dart';
import 'package:get/get.dart';

void main() {
  Get.put(CategoryController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
