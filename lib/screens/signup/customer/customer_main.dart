import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant/prefUtils/message_utills.dart';
import 'package:meter/constant/res/app_color/app_color.dart';
import 'package:meter/constant/validationUtils/validation_utils.dart';
import 'package:meter/controller/auth/customer_auth_controller.dart';
import 'package:meter/widgets/custom_button.dart';
import 'package:meter/widgets/custom_textfield.dart';
import 'package:meter/widgets/text_field_country_picker.dart';

import '../../../constant/routes/routes_name.dart';


class CustomerLoginMain extends StatelessWidget {
  const CustomerLoginMain({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerAuthController());
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.04,
            ),
            CustomTextField(
                validator: ValidationUtils.validateRequired("Name"),
                controller: controller.nameController,
                hintText: "Enter Your Name".tr,
                title: "Name".tr),
            CustomTextField(
                validator: ValidationUtils.validateEmail,
                controller: controller.emailController,
                hintText: "Enter your email",
                title: "Email".tr),
            Obx(
              () => TextFieldCountryPicker(
                isVerifySucces: controller.verifyMessage.value ==
                    "Success", //"Success"  change when deliver to client
                hintText: "115203867",
                controller: controller.phoneNumberController,
                flagPath: controller.flagUri.value,
                countryShortCode: controller.countryCode.value,
                countryCode: (CountryCode countryCode) {
                  controller.onChangeFlag(countryCode.flagUri ?? "",
                      countryCode.dialCode ?? "", countryCode.code ?? "");
                },
                onTapSuffix: () {
                  if (controller.verifyMessage.value == "Success") {
                    ShortMessageUtils.showSuccess("Already verified");
                  } else if (controller.sendOtpLoading.value) {
                  } else {
                    controller.sendOtp();
                  }
                },
                verifyColor: controller.verifyMessage.value == "Success"
                    ? AppColor.semiTransparentDarkGrey
                    : AppColor.primaryColor,
                verifyText: controller.sendOtpLoading.value
                    ? "Loading..."
                    : (controller.verifyMessage.value == "Success"
                        ? controller.verifyMessage.value
                        : "Verify"),
                title: "Phone Number".tr,
              ),
            ),
            SizedBox(
              height: Get.height * 0.07,
            ),
            MyCustomButton(
                title: "Register".tr,
                onTap: () {
                  if (_formKey.currentState!.validate() &&
                          controller.verifyMessage.value !=
                              "Success" //Change to Success
                      ) {
                    Get.toNamed(RoutesName.customerGeneralInfoScreen);
                  } else {
                    if (!controller.validatePhoneNumber()) {
                      ShortMessageUtils.showError(
                          "Please enter valid phone number");
                    } else if (controller.verifyMessage.value != "Success") {
                      ShortMessageUtils.showError("Please verify first");
                    } else {
                      ShortMessageUtils.showError("Please fill all fields");
                    }
                  }
                  // Get.toNamed(RoutesName.customerGeneralInfoScreen);
                })
          ],
        ),
      ),
    );
  }
}
