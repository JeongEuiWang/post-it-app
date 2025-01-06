// import 'package:flutter/material.dart';
// import 'package:post_it/controller/category.controller.dart';
// import 'package:get/get.dart';

// class CategoryButtonsWidget extends StatelessWidget {
//   final CategoryController controller = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: ToggleButtons(
//             borderRadius: BorderRadius.circular(20),
//             borderColor: Colors.grey,
//             selectedBorderColor: Colors.blue,
//             fillColor: Colors.blue.withOpacity(0.2),
//             selectedColor: Colors.blue,
//             color: Colors.black,
//             isSelected: List.generate(
//               controller.filters.length,
//               (index) => controller.selectedFilterIndex.value == index,
//             ),
//             onPressed: (index) {
//               controller.selectFilter(index);
//             },
//             children: controller.filters
//                 .map((filter) => Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Text(filter.name),
//                     ))
//                 .toList(),
//           ),
//         ));
//   }
// }
