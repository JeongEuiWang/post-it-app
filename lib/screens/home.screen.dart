import 'package:flutter/material.dart';
import 'package:post_it/widgets/all_articles_tab.dart';
import 'package:post_it/widgets/appBars/home_app_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: HomeAppBar(),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
          child: Column(
            children: [
              Expanded(
                child: AllArticlesTab(),
              ),
            ],
          ),
        ));
  }
}
