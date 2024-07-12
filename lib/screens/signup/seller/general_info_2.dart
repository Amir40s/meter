import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/auth_controller/seller_auth_controller.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/routes/routes_name.dart';
import 'package:meter_app/utils/app_textstyle.dart';
import 'package:meter_app/utils/backend_util/image_util.dart';
import 'package:meter_app/utils/pref_util.dart';
import 'package:meter_app/utils/validation_utils.dart';
import 'package:meter_app/view/auth/Signup/seller_login/face_auth.dart';
import 'package:meter_app/widget/containers/image_pick_container.dart';
import 'package:meter_app/widget/custom_loading.dart';
import 'package:meter_app/widget/header.dart';
import 'package:meter_app/widget/text_widget.dart';
import 'package:meter_app/widget/textfield.dart';
import '../../../../widget/containers/button.dart';

class SellerSecondGeneralInfo extends StatelessWidget {
  const SellerSecondGeneralInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SellerAuthController>();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
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
                        child: ImagePickContainer(
                          title: "Click to upload \n your papers",
                          onTap: () {
                            ImageUtil.pickAndUpdateFile(
                                controller.pdfFileName, controller.pdfFilePath);
                          },
                          fileName: controller.pdfFileName.value,
                          isFile: controller.pdfFilePath.value != "",
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
                      height: Get.height * 0.04,
                    ),
                    Obx(() => checkBoxWithTitle(
                          controller.isSellerAgreeTermsChecked.value,
                          RichText(
                            text: TextSpan(
                              style: AppTextStyle.dark14,
                              children: [
                                TextSpan(text: 'I agree to the '.tr),
                                TextSpan(
                                  text: 'terms & conditions'.tr,
                                  style: AppTextStyle.dark14
                                      .copyWith(color: AppColor.primaryColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      log('Navigate to terms & conditions');
                                    },
                                ),
                                TextSpan(text: ' by creating account.'.tr),
                              ],
                            ),
                          ),
                          (newValue) =>
                              controller.toggleSellerAgreeTerms(newValue),
                        )),
                    Obx(() => checkBoxWithTitle(
                          controller.isSellerAccurateInfoChecked.value,
                          const TextWidget(
                              textAlign: TextAlign.start,
                              title:
                                  "Commitment to the accuracy of information.",
                              textColor: AppColor.semiTransparentDarkGrey,
                              fontSize: 14),
                          (newValue) =>
                              controller.toggleSellerAccurateInfo(newValue),
                        )),
                    Obx(() => checkBoxWithTitle(
                          controller.isSellerPayDuesChecked.value,
                          const TextWidget(
                              textAlign: TextAlign.start,
                              title:
                                  "Commitment to pay meter app dues, estimated at 10% of the project value.",
                              textColor: AppColor.semiTransparentDarkGrey,
                              fontSize: 14),
                          (newValue) =>
                              controller.toggleSellerPayDues(newValue),
                        )),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => controller.sellerLoading.value
              ? Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.only(
                      left: Get.width / 2.3, right: Get.width / 2.3),
                  height: Get.height * 0.04,
                  child: const CustomLoading())
              : Container(
                  height: Get.height * 0.12,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: MyCustomButton(
                        title: "Continue",
                        onTap: () {
                          // Get.offAllNamed(RoutesName.sellerFaceAuth);
                          controller.sellerCompleteRegister(
                            context,
                            formKey: _formKey,
                          );
                        }),
                  )),
        ),
      ),
    );
  }
}

Widget checkBoxWithTitle(
    bool checkValue, Widget title, Function(bool?)? onChanged) {
  return Row(
    children: [
      Transform.scale(
        scale: 1.3,
        child: Checkbox(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          activeColor: AppColor.primaryColor,
          checkColor: AppColor.whiteColor,
          // overlayColor: WidgetStateProperty<Color>,
          value: checkValue,
          onChanged: onChanged,
        ),
      ),
      Flexible(child: title),
    ],
  );
}
