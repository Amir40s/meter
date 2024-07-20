import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../constant.dart';
import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_rich_text.dart';
import '../../widgets/text_widget.dart';

class VerificationBottomSheet extends StatelessWidget {
  final String phoneNumber;
  final TextEditingController controller;
  final bool isLoadingVerify;
  final bool showResend;
  final VoidCallback onResendCodeTap;
  final VoidCallback onVerifyTap;

  const VerificationBottomSheet({
    Key? key,
    required this.phoneNumber,
    required this.controller,
    required this.isLoadingVerify,
    required this.showResend,
    required this.onResendCodeTap,
    required this.onVerifyTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.50,
      decoration: const BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.01,
              ),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(
                    AppImage.cancel,
                    width: 40,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              const TextWidget(
                title: "Verification",
                fontSize: 20,
                textColor: AppColor.semiDarkGrey,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              CustomRichText(
                firstSize: 16,
                secondSize: 16,
                firstTextColor: AppColor.semiTransparentDarkGrey,
                firstText: "Code has been sent to",
                secondText: phoneNumber,
                press: () {},
              ),
              SizedBox(
                height: Get.height * 0.04,
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
                        border:
                        Border.all(color: AppColor.semiTransparentDarkGrey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    preFilledWidget: const SizedBox(width: 58),
                    autofocus: true,
                    onCompleted: (value) {},
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              CustomRichText(
                firstSize: 16,
                secondSize: 16,
                firstText: "Haven’t got the code yet?",
                secondText: showResend ? "Resend Code" : "",
                press: onResendCodeTap,
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              CustomButton(
                title: isLoadingVerify ? "Verifying..." : "Verify",
                onTap: onVerifyTap,
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
