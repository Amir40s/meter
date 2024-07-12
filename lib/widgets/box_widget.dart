import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/widgets/text_widget.dart';


import '../constant/res/app_color/app_color.dart';

class BoxWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String imagePath;
  final String activeImagePath;
  final String title;
  final bool isActive;
  const BoxWidget(
      {super.key,
        required this.imagePath,
        required this.title,
        required this.isActive,
        required this.onTap,
        required this.activeImagePath});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          // margin:EdgeInsets.only(l),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isActive
                    ? AppColor.primaryColor
                    : AppColor.semiTransparentDarkGrey,
              )),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.01,
              ),
              Image.asset(
                isActive ? activeImagePath : imagePath,
                width: 24,
                height: 24,
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              TextWidget(
                  title: title,
                  textColor: isActive
                      ? AppColor.primaryColor
                      : AppColor.semiTransparentDarkGrey,
                  fontSize: 14)
            ],
          ),
        ),
      ),
    );
  }
}
