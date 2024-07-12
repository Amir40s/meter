import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meter/widgets/text_widget.dart';

import '../constant/res/app_color/app_color.dart';
import '../constant/res/app_images/app_images.dart';
import 'custom_button.dart';
class DialogWidget extends StatelessWidget {
  final String title;
  final double height;
  final String description;
  final String mainButtonText;
  final VoidCallback mainButtonTap;
  const DialogWidget(
      {super.key,
        required this.title,
        required this.description,
        required this.mainButtonText,
        required this.mainButtonTap,
        this.height = 0.40});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: Get.height * height, // Set the maximum height here
              maxWidth: Get.width),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Image.asset(
                          AppImage.cancel,
                          width: 45,
                        )),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  TextWidget(
                    title: title,
                    textColor: AppColor.semiDarkGrey,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  TextWidget(
                    title: description,
                  ),
                  SizedBox(
                    height: Get.height * 0.06,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MyCustomButton(
                          title: "Cancel",
                          textColor: AppColor.semiTransparentDarkGrey,
                          backgroundColor: Colors.transparent,
                          onTap: () {
                            Get.back();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: MyCustomButton(
                            backgroundColor: AppColor.primaryColorShade1,
                            title: mainButtonText,
                            onTap: mainButtonTap),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}