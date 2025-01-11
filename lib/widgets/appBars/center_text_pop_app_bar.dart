
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CenterTextPopAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String centerText;
  const CenterTextPopAppBar({super.key, required this.centerText});

  @override
  Size get preferredSize => Size.fromHeight(48.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      title: Text(centerText,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF222222),
              fontFamily: 'Pretendard')),
      centerTitle: true,
    );
  }
}
