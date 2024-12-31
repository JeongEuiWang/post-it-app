import 'package:flutter/material.dart';

class TabContentWidget extends StatelessWidget {
  final String content;

  const TabContentWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        content,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
