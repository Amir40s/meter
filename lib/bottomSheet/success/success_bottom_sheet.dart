import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/text_widget.dart';
class SuccessBottomSheet extends StatelessWidget {
  final String title;
  final VoidCallback? onDoneTap;
  final String? desc;
  final double height;
  final String buttonTitle;
  final Widget? newWidget;
  const SuccessBottomSheet(
      {super.key,
        required this.title,
        this.onDoneTap,
        this.desc,
        this.height = 0.50,
        required this.buttonTitle,
        this.newWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * height,
      decoration: BoxDecoration(
          color: AppColor.whiteColor, borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: Get.height * height, // Set the maximum height here
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.02,
                ),
                newWidget ?? Image.asset(AppImage.security),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                TextWidget(
                  title: title,
                  textColor: AppColor.semiDarkGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                const TextWidget(
                    title: "Successfully🎉",
                    fontWeight: FontWeight.bold,
                    textColor: AppColor.primaryColor,
                    fontSize: 20),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                TextWidget(
                    title: desc ?? "",
                    textColor: AppColor.semiTransparentDarkGrey,
                    fontSize: 13),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                MyCustomButton(title: buttonTitle, onTap: onDoneTap!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}