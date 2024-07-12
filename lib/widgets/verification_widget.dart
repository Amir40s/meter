import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/widgets/text_widget.dart';
import 'package:pinput/pinput.dart';

import '../constant.dart';
import '../constant/res/app_color/app_color.dart';
import '../constant/res/app_images/app_images.dart';
import 'custom_back_button.dart';
import 'custom_button.dart';
import 'custom_loading.dart';

class VerificationWidget extends StatelessWidget {
  final TextEditingController controller;
  final String buttonTitle;
  final VoidCallback onTap;
  final VoidCallback onResendTap;
  final bool showResend;
  final bool showLoading;
  final String countryCode;
  final String phoneNumber;
  const VerificationWidget(
      {super.key,
      required this.controller,
      this.showResend = true,
      required this.buttonTitle,
      required this.onTap,
      this.showLoading = false,
      required this.onResendTap,
      required this.countryCode,
      required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    log("phone number $countryCode");
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Container(
                  width: Get.width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        child: Image.asset(
                          AppImage.meter,
                          width: Get.width / 1.5,
                        ),
                      ),
                      const Positioned(
                          left: 0, top: 0, child: CustomBackButton()),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                const TextWidget(
                  title: "Verification",
                  textColor: AppColor.semiDarkGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextWidget(
                      title: "${"Code has been send".tr} ${countryCode}",
                      textColor: AppColor.semiTransparentDarkGrey,
                      fontSize: 16,
                    )),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 50,
                    child: Pinput(
                      length: 4,
                      controller: controller,
                      defaultPinTheme: PinTheme(
                        height: 50,
                        width: 50,
                        textStyle: AppTextStyle.dark14
                            .copyWith(color: AppColor.semiDarkGrey),
                        decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            border: Border.all(
                                color: AppColor.semiTransparentDarkGrey),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      preFilledWidget: const SizedBox(width: 58),
                      autofocus: true,
                      onCompleted: (value) {},
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                !showLoading
                    ? MyCustomButton(title: buttonTitle, onTap: onTap)
                    : const CustomLoading(),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                RichText(
                  text: TextSpan(
                    style: AppTextStyle.dark14,
                    children: [
                      TextSpan(text: 'Haven’t got the code yet?'.tr),
                      showResend
                          ? TextSpan(
                              text: ' ${"Resend Code".tr}',
                              style: AppTextStyle.dark14
                                  .copyWith(color: AppColor.primaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = onResendTap,
                            )
                          : const TextSpan(text: ''),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
