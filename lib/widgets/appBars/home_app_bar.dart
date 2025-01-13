import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:post_it/constants/color.dart';
import 'package:post_it/screens/setting.screen.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  Future<void> signOutUser() async {
    try {
      // Firebase 로그아웃
      await FirebaseAuth.instance.signOut();

      // Google 로그아웃
      final GoogleSignIn googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }
      print("User successfully signed out.");
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(48.0);
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Post IT',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222222),
                    fontFamily: 'Pretendard')),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingScreen(),
                      ));
                },
                child: SvgPicture.asset(
                  'assets/images/icon_setting.svg',
                  height: 24.0,
                  width: 24.0,
                  colorFilter:
                      ColorFilter.mode(CustomColors.grey, BlendMode.srcIn),
                ))
          ],
        ));
  }
}
