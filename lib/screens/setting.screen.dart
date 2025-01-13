import 'package:flutter/material.dart';
import 'package:post_it/widgets/all_articles_tab.dart';
import 'package:post_it/widgets/appBars/center_text_pop_app_bar.dart';
import 'package:post_it/widgets/home_tab_view.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CenterTextPopAppBar(
          centerText: "설정",
        ),
        body: Text("Setting"));
  }
}
