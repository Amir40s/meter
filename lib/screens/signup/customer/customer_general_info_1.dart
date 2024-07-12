import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant/res/app_color/app_color.dart';
import 'package:meter/constant/validationUtils/validation_utils.dart';
import 'package:meter/controller/auth/customer_auth_controller.dart';
import 'package:meter/widgets/check_box_widget.dart';
import 'package:meter/widgets/custom_button.dart';
import 'package:meter/widgets/custom_header.dart';
import 'package:meter/widgets/custom_loading.dart';
import 'package:meter/widgets/custom_textfield.dart';

import '../../../constant.dart';

class CustomerFirstGeneralInfo extends StatelessWidget {
  const CustomerFirstGeneralInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerAuthController());
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(children: [
              CustomHeader(
                showProgress: true,
                title: "General Info".tr,
                progressWidth: 1.4,
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Obx(() => Padding(
                    padding: const EdgeInsets.only(left: 14.0, right: 14),
                    child: CustomTextField(
                        validator:
                            ValidationUtils.validateLengthRange("Password", 5),
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
                height: Get.height * 0.03,
              ),
              Obx(
                () => CheckBoxWidget(
                  checkValue: controller.isAgreeTermsChecked.value,
                  title: RichText(
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
                              // Navigate to terms & conditions page or handle click event
                              print('Navigate to terms & conditions');
                            },
                        ),
                        TextSpan(text: ' by creating account.'.tr),
                      ],
                    ),
                  ),
                  onChanged: (newValue) =>
                      controller.toggleAgreeTerms(newValue),
                ),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: Obx(
                    () => controller.customerLoading.value
                        ? const CustomLoading()
                        : MyCustomButton(
                            title: "Continue".tr,
                            onTap: () {
                              controller.completeCustomerRegistration(_formKey);
                            }),
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
