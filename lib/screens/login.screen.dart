import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      appBar: AppBar(title: Text("Post IT")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => login(),
          child: Text("Login with Google"),
        ),
      ),
    );
  }
}
