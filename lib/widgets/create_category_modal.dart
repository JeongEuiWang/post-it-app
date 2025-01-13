import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:post_it/constants/color.dart';
import 'package:post_it/constants/font.dart';
import 'package:post_it/controller/category.controller.dart';
import 'package:post_it/widgets/custom_input.dart';

import '../controller/user.controller.dart';

class CreateCategoryModal {
  static void show(BuildContext context,
      {required AnimationController animationController}) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final userId = Get.find<UserController>().userId;
    final _categoryController = Get.find<CategoryController>();

    Future<void> onCreate() async {
      if (formKey.currentState!.validate()) {
        try {
          await _categoryController.createCategory(
              userId: userId!,
              name: nameController.text,
              fromEmail: emailController.text);
          Fluttertoast.showToast(
              msg: "카테고리가 생성되었어요",
              gravity: ToastGravity.TOP,
              backgroundColor: CustomColors.primary,
              textColor: CustomColors.white);
          Navigator.pop(context);
        } catch (e) {
          print(e);
          Fluttertoast.showToast(
              msg: e.toString(),
              gravity: ToastGravity.TOP,
              backgroundColor: CustomColors.red,
              textColor: CustomColors.white);
        }
      }
    }

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        ),
        enableDrag: true,
        isDismissible: true,
        backgroundColor: CustomColors.white,
        constraints: const BoxConstraints(
          minWidth: double.infinity,
        ),
        transitionAnimationController: animationController,
        builder: (context) => _createCategoryWidget(
            context: context,
            nameController: nameController,
            formKey: formKey,
            emailController: emailController,
            onCreate: onCreate)).then((value) {
      _categoryController.getCategories(userId: userId);
    });
  }
}

Widget _createCategoryWidget({
  required BuildContext context,
  required TextEditingController nameController,
  required GlobalKey<FormState> formKey,
  required TextEditingController emailController,
  required void Function() onCreate,
}) {
  final double screenHeight = MediaQuery.of(context).size.height;
  final double bottomSheetHeight = screenHeight * 0.7;
  return SizedBox(
    width: double.infinity,
    height: bottomSheetHeight,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        children: [
          _createCategoryHeader(context),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _createCategoryForm(
                        nameController: nameController,
                        formKey: formKey,
                        emailController: emailController),
                    _createCategoryFooter(onPressed: onCreate),
                  ],
                )),
          )
        ],
      ),
    ),
  );
}

Widget _createCategoryHeader(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "카테고리 생성하기",
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: CustomColors.black,
            fontFamily: pretendard),
      ),
      GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: SvgPicture.asset(
          'assets/images/icon_x.svg',
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(CustomColors.grey, BlendMode.srcIn),
        ),
      )
    ],
  );
}

Widget _createCategoryForm({
  required TextEditingController nameController,
  required GlobalKey<FormState> formKey,
  required TextEditingController emailController,
}) {
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "이메일을 입력해주세요.";
    }
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return "유효한 이메일 형식이 아니에요";
    }
    return null;
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "이름을 입력해주세요.";
    }
    return null;
  }

  return Form(
    key: formKey,
    child: Column(
      children: [
        CustomInput(
          label: "카테고리 이름",
          description: "홈에서 표시 될 카테고리의 이름을 입력하세요.",
          controller: nameController,
          validator: nameValidator,
        ),
        const SizedBox(height: 32),
        CustomInput(
          label: "이메일",
          description: "구독형 아티클의 송신자 이메일을 입력하세요.",
          controller: emailController,
          validator: emailValidator,
        )
      ],
    ),
  );
}

Widget _createCategoryFooter({required void Function() onPressed}) {
  return Column(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/icon_caution.svg',
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 6),
              Text("안내사항",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.black,
                      fontFamily: pretendard)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
              "구독 아티클을 전송받을 이메일을 정확히 입력해주세요!\n잘못된 이메일로 입력하시면 아티클 목록을 조회할 수 없어요.",
              style: TextStyle(
                  fontSize: 14,
                  color: CustomColors.grey,
                  fontWeight: FontWeight.w400,
                  fontFamily: pretendard)),
        ],
      ),
      const SizedBox(height: 24),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 40),
          backgroundColor: CustomColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Text("생성하기",
            style: TextStyle(
                color: CustomColors.white,
                fontFamily: pretendard,
                fontSize: 18,
                fontWeight: FontWeight.w500)),
      )
    ],
  );
}
