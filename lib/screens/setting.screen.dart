import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:post_it/constants/color.dart';
import 'package:post_it/constants/font.dart';
import 'package:post_it/controller/user.controller.dart';
import 'package:post_it/screens/splash.screen.dart';
import 'package:post_it/widgets/appBars/center_text_pop_app_bar.dart';
import 'package:post_it/widgets/create_category_modal.dart';

class SettingScreen extends StatefulWidget {
  Key appKey = UniqueKey();
  @override
  SettingScreenState createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final UserController userController = Get.find<UserController>();
  @override
  void initState() {
    _animationController = BottomSheet.createAnimationController(this);
    _animationController.duration = Duration(milliseconds: 300);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CenterTextPopAppBar(
          centerText: "설정",
        ),
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
                padding:
                    EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 20,
                      children: [
                        Text(
                          "카테고리",
                          style: TextStyle(
                              color: CustomColors.grey,
                              fontSize: 14,
                              fontFamily: pretendard),
                        ),
                        GestureDetector(
                          onTap: () {
                            CreateCategoryModal.show(context,
                                animationController: _animationController);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "카테고리 생성",
                                style: TextStyle(
                                    color: CustomColors.black,
                                    fontSize: 16,
                                    fontFamily: pretendard),
                              ),
                              SvgPicture.asset('assets/images/icon_arrow.svg',
                                  width: 6, height: 12)
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ))));
  }
}
