import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/widgets/text_widget.dart';

import '../constant/res/app_color/app_color.dart';

class CategoriesColumn extends StatelessWidget {
  final String imagePath;
  final String title;
  const CategoriesColumn(
      {super.key, required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(imagePath),
          backgroundColor: AppColor.lightGreyShade,
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: Get.width * 0.18), // Specify your width here
          child: TextWidget(
            title: title,
            fontSize: 14,
            textColor: AppColor.semiDarkGrey,
          ),
        )
      ],
    );
  }
}
