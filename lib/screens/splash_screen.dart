import 'package:flutter/material.dart';
import 'package:post_it/screens/home_screen.dart';
import 'package:post_it/screens/login_screen.dart';
import 'package:post_it/services/login_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // 로그인 여부 확인 (예제에서는 2초 후 결과 반환)
  Future<void> _checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 2)); // 스플래시 화면 대기 시간
    bool isLoggedIn = await AuthService.mockLoginCheck();

    // 로그인 상태에 따라 화면 전환
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'My App',
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
