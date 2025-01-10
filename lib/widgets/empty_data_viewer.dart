import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:post_it/constants/color.dart';
import 'package:post_it/constants/font.dart';

class EmptyDataViewer extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const EmptyDataViewer({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Center(
          child: Column(children: [
        SvgPicture.asset(imagePath,
            width: constraints.maxWidth * 0.8, fit: BoxFit.cover),
        Text(title,
            style: TextStyle(
                fontSize: 20,
                fontFamily: pretendard,
                fontWeight: FontWeight.w600)),
        Text(description,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                fontFamily: pretendard,
                color: CustomColors.grey,
                fontWeight: FontWeight.w400))
      ]));
    });
  }
}
