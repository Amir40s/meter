import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant.dart';
import 'package:meter/constant/res/app_color/app_color.dart';
import 'package:meter/constant/res/app_images/app_images.dart';
import 'package:meter/controller/provider_controller/send_work/delevering_service_controller.dart';
import 'package:meter/widgets/custom_button.dart';
import 'package:meter/widgets/image_pick_widget.dart';
import 'package:meter/widgets/text_widget.dart';

import '../../../../widgets/custom_header.dart';
import '../../../../widgets/custom_textfield.dart';
import '../../../../widgets/radio/group_raadio_widget.dart';
import '../../../signup/seller/general_info_2.dart';
import 'delivering_purpose_pricing.dart';

class DeliveringFirstService extends StatelessWidget {
  const DeliveringFirstService({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DeliveringServiceController>();
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
            height: Get.height * 0.12,
            margin:
                EdgeInsets.only(bottom: Get.height * 0.02, left: 14, right: 14),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  Expanded(
                    child: MyCustomButton(
                      onTap: () {},
                      title: "Print",
                      backgroundColor: Colors.transparent,
                      borderSideColor: AppColor.primaryColor,
                      textColor: AppColor.primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  Expanded(
                    child: MyCustomButton(
                      onTap: () async {
                        Get.to(DeliveringPurposePricing());
                        // Get.dialog(CustomSuccessScreen(
                        //   title: "work has been sent",
                        //   height: 0.60,
                        //   buttonTitle: "Done",
                        //   desc: "Congratulations! Your work has been sent",
                        //   newWidget: Lottie.asset(AppImage.workDone),
                        //   onDoneTap: () {
                        //     //Change to original
                        //     Get.back();
                        //     Get.back();
                        //     Get.back();
                        //     Get.back();
                        //   },
                        // ));
                      },
                      title: "Send Work".tr,
                    ),
                  ),
                ],
              ),
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const CustomHeader(
                title: "Delivering Service",
                showProgress: true,
                progressWidth: 1,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    const ImagePickWidget(
                        title: "Click to upload\nWork copy here"),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    CustomTextField(
                        hintText: "Enter office name",
                        title: "Electronic signature",
                        controller: controller.electronicSignatureController),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Obx(() => checkBoxWithTitle(
                          controller.isAccurateInfoChecked.value,
                          const TextWidget(
                              textAlign: TextAlign.start,
                              title: "Commitment to pay Meter application dues",
                              textColor: AppColor.semiTransparentDarkGrey,
                              fontSize: 14),
                          (newValue) => controller.toggleAccurateInfo(newValue),
                        )),
                    Obx(() => checkBoxWithTitle(
                          controller.isPayDuesChecked.value,
                          const TextWidget(
                              textAlign: TextAlign.start,
                              title:
                                  "Commitment to the accuracy of information.",
                              textColor: AppColor.semiTransparentDarkGrey,
                              fontSize: 14),
                          (newValue) => controller.togglePayDues(newValue),
                        )),
                    Obx(() => checkBoxWithTitle(
                          controller.isAgreeTermsChecked.value,
                          RichText(
                            text: TextSpan(
                              style: AppTextStyle.dark14,
                              children: [
                                TextSpan(text: 'Agree to the '.tr),
                                TextSpan(
                                  text: 'privacy policy & terms'.tr,
                                  style: AppTextStyle.dark14
                                      .copyWith(color: AppColor.primaryColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      log('Navigate to terms & conditions');
                                    },
                                ),
                                TextSpan(text: ' ${"of service"}'.tr),
                              ],
                            ),
                          ),
                          (newValue) => controller.toggleAgreeTerms(newValue),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
