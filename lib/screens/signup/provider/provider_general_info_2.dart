import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant/res/app_color/app_color.dart';
import 'package:meter/controller/auth/provider_auth_controller.dart';
import 'package:meter/widgets/check_box_widget.dart';
import 'package:meter/widgets/custom_loading.dart';

import '../../../constant.dart';
import '../../../constant/errorUtills/image_utils.dart';
import '../../../constant/res/app_images/app_images.dart';
import '../../../constant/validationUtils/validation_utils.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_header.dart';
import '../../../widgets/custom_textfield.dart';


class ProviderSecondGeneralInfo extends StatelessWidget {
  const ProviderSecondGeneralInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProviderAuthController>();

    final _formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        bottomNavigationBar: Obx(() => controller.isLoading.value
            ? Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.only(
                    left: Get.width / 2.3, right: Get.width / 2.3),
                height: Get.height * 0.04,
                child: const CustomLoading())
            : Container(
                height: Get.height * 0.08,
                margin: EdgeInsets.only(
                    bottom: Get.height * 0.05, left: 14, right: 14),
                child: Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: MyCustomButton(
                      title: "Continue".tr,
                      onTap: () {
                        controller.completeProviderRegistration(_formKey);
                      }),
                ))),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeader(
                  showProgress: true,
                  title: "General Info".tr,
                  progressWidth: 1.4,
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(left: 14.0, right: 14),
                    child: GestureDetector(
                      onTap: () {
                        ImageUtil.pickAndUpdateImage(controller.imagePath);
                      },
                      child: controller.imagePath.value == ""
                          ? Image.asset(
                              AppImage.pickImage,
                              height: Get.height * 0.17,
                            )
                          : ClipOval(
                              child: Image.file(
                                File(controller.imagePath.value),
                                height: Get.height * 0.17,
                                width: Get.height *
                                    0.17, // Ensure the width is the same as the height for a circle
                                fit: BoxFit
                                    .cover, // This will ensure the image covers the circle completely
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Obx(() => Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14),
                      child: CustomTextField(
                          validator: ValidationUtils.validateLengthRange(
                              "Password", 5),
                          onSuffixIconTap: () {
                            controller.togglePassword();
                          },
                          controller: controller.passwordController,
                          isObscure: controller.passwordHide.value,
                          showSuffix: true,
                          hintText: "Enter your password".tr,
                          title: "Password".tr),
                    )),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Obx(() => Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14),
                      child: CustomTextField(
                          validator: ValidationUtils.validateLengthRange(
                              "Confirm Password", 5),
                          controller: controller.confirmPasswordController,
                          onSuffixIconTap: () {
                            controller.toggleConfirmPassword();
                          },
                          isObscure: controller.confirmPasswordHide.value,
                          showSuffix: true,
                          hintText: "Re-enter password".tr,
                          title: "Confirm Password".tr),
                    )),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Obx(() => CheckBoxWidget(
                    checkValue:   controller.isAgreeTermsChecked.value,
                     title:  RichText(
                        text: TextSpan(
                          style: AppTextStyle.dark14.copyWith(fontSize: 12),
                          children: [
                            TextSpan(text: 'I agree to the '.tr),
                            TextSpan(
                              text: 'terms & conditions'.tr,
                              style: AppTextStyle.dark14
                                  .copyWith(color: AppColor.primaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle click event
                                  print('Navigate to terms & conditions');
                                },
                            ),
                            TextSpan(text: ' by creating account.'.tr),
                          ],
                        ),
                      ),
                    onChanged:   (newValue) => controller.toggleAgreeTerms(newValue),
                    )),
                SizedBox(
                  height: Get.height * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
