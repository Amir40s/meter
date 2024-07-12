import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/bottomSheet/success/success_bottom_sheet.dart';
import 'package:meter/constant/res/app_color/app_color.dart';
import 'package:meter/constant/routes/routes_name.dart';
import 'package:meter/widgets/custom_button.dart';
import 'package:meter/widgets/custom_header.dart';
import 'package:meter/widgets/text_widget.dart';

import '../../constant/res/app_images/app_images.dart';
import '../../controller/auth/finger_recognize_controller.dart';
import '../../widgets/custom_loading.dart';

class FingerAuth extends StatelessWidget {
  final FingerAuthController _authController = Get.put(FingerAuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Obx(() => Container(
            height: Get.height * 0.12,
            margin:
                EdgeInsets.only(bottom: Get.height * 0.02, left: 14, right: 14),
            child: _authController.isContinueLoading.value
                ? const CustomLoading()
                : Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: MyCustomButton(
                            onTap: () {
                              Get.bottomSheet(
                                SuccessBottomSheet(
                                  title: "Created Account",
                                  onDoneTap: () async {
                                    Get.offAllNamed(RoutesName.bottomNavMain);
                                  },
                                  desc:
                                      "Congratulations! Your account has been created. Click continue to start"
                                          .tr,
                                  buttonTitle: "Done".tr,
                                ),
                              );
                            },
                            title: "Skip",
                            backgroundColor: AppColor.lightBlueShade,
                            textColor: AppColor.primaryColor,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: MyCustomButton(
                            onTap: () async {
                              Get.bottomSheet(
                                SuccessBottomSheet(
                                  title: "Created Account",
                                  onDoneTap: () async {
                                    await _authController.onContinueClick();
                                  },
                                  desc:
                                      "Congratulations! Your account has been created. Click continue to start"
                                          .tr,
                                  buttonTitle: "Done".tr,
                                ),
                              );
                            },
                            title: "Continue".tr,
                          ),
                        ),
                      ],
                    ),
                  ))),
        backgroundColor: AppColor.whiteColor,
        body: Obx(() => Column(
              children: [
                CustomHeader(title: "Touch ID Security".tr),
                const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: TextWidget(
                      title:
                          "Secure your account with your fingerprint using Touch ID",
                      textColor: AppColor.semiDarkGrey,
                      fontSize: 14),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                if (_authController.isFingerprintAvailable.value)
                  _authController.isLoading.value
                      ? const CustomLoading()
                      : _authController.isAuthenticated.value
                          ? Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                      AppImage.authenticatedFinger)),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: GestureDetector(
                                  onTap: () {
                                    _authController.authenticate();
                                  },
                                  child:
                                      Image.asset(AppImage.proccessingFinger)),
                            ),
                if (!_authController.isFingerprintAvailable.value)
                  const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: TextWidget(
                      title: "Fingerprint sensor not available",
                      textColor: AppColor.primaryColor,
                      fontSize: 14,
                    ),
                  ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: TextWidget(
                      title:
                          "Please place your finger on the fingerprint sensor to get started",
                      textColor: AppColor.semiDarkGrey,
                      fontSize: 14),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                if (_authController.isLoading.value)
                  const CustomLoading(), // Show loading indicator
                if (_authController.isAuthenticated.value)
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppImage.check),
                        const SizedBox(
                          width: 10,
                        ),
                        const TextWidget(
                            title: "Authentication successful",
                            textColor: AppColor.successColor,
                            fontSize: 14)
                      ],
                    ),
                  ),
              ],
            )),
      ),
    );
  }
}
