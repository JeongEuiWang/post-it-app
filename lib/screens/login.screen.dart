import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:post_it/constants/color.dart';
import 'package:post_it/controller/user.controller.dart';

import 'home.screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final UserController _userController = Get.find<UserController>();

  Future<void> login() async {
    try {
      await _userController.handleLogin();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (err) {
      // toast
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          Column(
            children: [
              SvgPicture.asset(
                "assets/images/icon_logo_primary.svg",
                width: 80,
              ),
              Text(
                'Post IT',
                style: TextStyle(
                    fontSize: 38,
                    color: CustomColors.primary,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => login(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: CustomColors.border),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    "assets/images/icon_google.svg",
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Sign in with Google",
                    style: TextStyle(color: CustomColors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
