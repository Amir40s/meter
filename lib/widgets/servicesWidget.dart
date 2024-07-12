import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/widgets/text_widget.dart';

import '../constant/res/app_color/app_color.dart';

class ServicesWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback? onTap;
  const ServicesWidget(
      {super.key, required this.title, required this.imagePath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColor.lightGreyShade,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 70,
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            TextWidget(
                title: title, textColor: AppColor.semiDarkGrey, fontSize: 13)
          ],
        ),
      ),
    );
  }
}
