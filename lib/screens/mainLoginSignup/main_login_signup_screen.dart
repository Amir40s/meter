import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/screens/login/login_screen.dart';
import 'package:meter/screens/signup/signup_screen.dart';

import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../controller/auth/main_auth_controller.dart';
import '../../widgets/text_widget.dart';

class MainLoginSignupScreen extends StatelessWidget {
  MainLoginSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainAuthController>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Image.asset(
                  AppImage.meter,
                  width: Get.width / 1.5,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Obx(() {
                  if (controller.selectedLogin.value) {
                    return Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        TextWidget(
                            title: "Get Started Now",
                            textColor: AppColor.semiDarkGrey,
                            fontSize: 20),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: TextWidget(
                            title:
                                "Create an account or log in to explore about our app",
                            textColor: AppColor.semiTransparentDarkGrey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container(); // Or any other widget you want to display when the condition is false
                  }
                }),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: AppColor.lightBlueGrey,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColor.lightBlueGrey,
                        width: 1,
                      )),
                  child: Row(
                    children: [
                      Obx(() => Expanded(
                            child: GestureDetector(
                              onTap: () {
                                controller.changeActive(true);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: controller.selectedLogin.value
                                      ? Colors.transparent
                                      : AppColor.whiteColor,
                                ),
                                child: Center(
                                    child: TextWidget(
                                        title: "Log In",
                                        textColor: controller
                                                .selectedLogin.value
                                            ? AppColor.primaryColor
                                            : AppColor.semiTransparentDarkGrey,
                                        fontSize: 14)),
                              ),
                            ),
                          )),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                      Obx(
                        () => Expanded(
                          child: GestureDetector(
                            onTap: () {
                              controller.changeActive(false);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(11),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: !controller.selectedLogin.value
                                    ? Colors.transparent
                                    : AppColor.whiteColor,
                              ),
                              child: Center(
                                  child: TextWidget(
                                      title: "Sign Up",
                                      textColor: !controller.selectedLogin.value
                                          ? AppColor.primaryColor
                                          : AppColor.semiTransparentDarkGrey,
                                      fontSize: 14)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Obx(
                  () => controller.selectedLogin.value
                      ? const LoginScreen()
                      : const SignupScreen(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
