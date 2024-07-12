import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant/routes/routes_name.dart';

import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_rich_text.dart';
import '../../widgets/text_widget.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                width: Get.width,
                height: Get.height * 0.6,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppImage.onBoard),
                        fit: BoxFit.cover)),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: Get.height * 0.37,
                width: Get.width,
                padding: const EdgeInsets.all(15.0),
                decoration: const BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Image.asset(
                      AppImage.threedot,
                      width: Get.width * 0.25,
                    ),
                    SizedBox(
                      height: Get.height * 0.06,
                    ),
                    CustomRichText(
                        firstSize: 30,
                        secondSize: 30,
                        firstText: "Welcome To ",
                        secondText: "Meter",
                        press: () {}),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    const TextWidget(
                        fontSize: 14,
                        title:
                        "Your Trusted Partner in Engineering and Surveying Solutions"),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    CustomButton(
                        title: "Continue",
                        onTap: () {
                          Get.offAllNamed(RoutesName.onBoardWelcomeScreen);
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
