import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:post_it/controller/articles.controller.dart';
import 'package:post_it/screens/splash.screen.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:post_it/controller/category.controller.dart';
import 'package:post_it/controller/user.controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(CategoryController());
  Get.put(UserController());
  Get.put(ArticleController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey = Get.key;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}
