import 'package:flutter/material.dart';
import 'package:post_it/constants/color.dart';
import 'package:post_it/constants/font.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String description;
  final String? Function(String?)? validator;

  const CustomInput(
      {super.key,
      required this.controller,
      required this.label,
      this.validator,
      this.description = ""});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: pretendard)),
        const SizedBox(height: 4),
        description.isNotEmpty
            ? Text(description,
                style: TextStyle(
                    fontSize: 14,
                    color: CustomColors.grey,
                    fontWeight: FontWeight.w400,
                    fontFamily: pretendard))
            : SizedBox.shrink(),
        // const SizedBox(height: 8),
        TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: label,
              hintStyle: TextStyle(
                  fontSize: 16,
                  color: CustomColors.lightGrey,
                  fontWeight: FontWeight.w400,
                  fontFamily: pretendard),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: CustomColors.border),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: CustomColors.primary),
              ),
            ),
            validator: validator)
      ],
    );
  }
}
