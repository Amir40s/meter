import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/widgets/image_pick_widget.dart';
import 'package:meter/widgets/location/google_map.dart';

import '../../../constant.dart';
import '../../../constant/errorUtills/image_utils.dart';
import '../../../constant/res/app_color/app_color.dart';
import '../../../constant/res/app_images/app_images.dart';
import '../../../constant/validationUtils/validation_utils.dart';
import '../../../controller/services/request_service_consolation_controller.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_header.dart';
import '../../../widgets/custom_loading.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/text_widget.dart';
import '../../signup/seller/general_info_2.dart';

class ConsolationRequestService extends StatelessWidget {
  const ConsolationRequestService({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RequestServiceConsolationController>();
    final _formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const CustomHeader(
                  title: "Request a service",
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
                      Row(
                        children: [
                          Expanded(
                              child: CustomTextField(
                                  validator: ValidationUtils.validateRequired(
                                      "Region"),
                                  hintText: "Enter Region",
                                  title: "Region",
                                  controller: controller.regionController)),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: CustomTextField(
                                  richText: "(Optional)",
                                  hintText: "Enter City",
                                  title: "City",
                                  controller: controller.cityController)),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      CustomTextField(
                          hintText: "Enter Neighborhood",
                          title: "Neighborhood",
                          richText: "(Optional)",
                          controller: controller.neighborhoodController),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      CustomTextField(
                          readOnly: true,
                          onTap: () {
                            Get.to(GoogleMapScreen());
                          },
                          validator:
                              ValidationUtils.validateRequired("Location"),
                          hintText: "Location",
                          title: "Location",
                          prefixImagePath: AppImage.location,
                          controller: controller.locationController),
                      SizedBox(
                        height: Get.height * 0.04,
                      ),
                      Obx(() => ImagePickWidget(
                            title: "Click to upload",
                            onTap: () {
                              ImageUtil.pickAndUpdateFile(
                                  controller.fileName, controller.filePath);
                            },
                            fileName: controller.fileName.value,
                            isFile: controller.filePath.value != "",
                          )),
                      SizedBox(height: Get.height * 0.04),
                      Obx(() => checkBoxWithTitle(
                            controller.isPayMeterChecked.value,
                            const TextWidget(
                                title:
                                    "Commitment to pay Meter application dues",
                                textColor: AppColor.semiTransparentDarkGrey,
                                textAlign: TextAlign.start,
                                fontSize: 14),
                            (newValue) => controller.togglePayMeter(newValue),
                          )),
                      Obx(() => checkBoxWithTitle(
                            controller.isAccuracyChecked.value,
                            const TextWidget(
                              title:
                                  "Commitment to the accuracy of information.",
                              textColor: AppColor.semiTransparentDarkGrey,
                              fontSize: 14,
                              textAlign: TextAlign.start,
                            ),
                            (newValue) =>
                                controller.toggleAccuracyChecked(newValue),
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
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Obx(() => controller.loading.value
                          ? const CustomLoading()
                          : CustomButton(
                              title: "Submit Request",
                              onTap: () {
                                controller.onClickContinue(_formKey);

                                // Get.offAll(const BottomNavMain());
                              }))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
