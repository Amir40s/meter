import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SellerGeneralInfo extends StatelessWidget {
  const SellerGeneralInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SellerAuthController>();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomHeader(
                  showProgress: true,
                  title: "General Info".tr,
                  progressWidth: 2.5,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 14.0, right: 14, top: 14.0),
                  child: CustomTextField(
                      validator: ValidationUtils.validateRequired("Owner Name"),
                      controller: controller.ownerNameController,
                      hintText: "Enter owner name",
                      title: "Owner Name".tr),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: Obx(
                    () => CustomTextFieldWithCountryPicker(
                      isVerifySucces: controller.verifyMessage.value ==
                          "Success", //change to == "Success"
                      hintText: "115203867",
                      controller: controller.phoneNumberController,
                      flagPath: controller.phoneNumberFlagUri.value,
                      countryShortCode: controller.phoneNumberCountryCode.value,
                      countryCode: (CountryCode countryCode) {
                        controller.onChangePhoneNumberFlag(
                            countryCode.flagUri ?? "",
                            countryCode.dialCode ?? "",
                            countryCode.code ?? "");
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
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: CustomTextField(
                      validator:
                          ValidationUtils.validateRequired("Manager Name"),
                      controller: controller.managerNameController,
                      hintText: "Enter manager name".tr,
                      title: "Manager Name".tr),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: Obx(
                    () => CustomTextFieldWithCountryPicker(
                      hintText: "115203867",
                      controller: controller.managerPhoneNumberController,
                      flagPath: controller.managerPhoneNumberFlagUri.value,
                      countryCode: (CountryCode countryCode) {
                        controller.onChangeFlag(countryCode.flagUri ?? "",
                            countryCode.dialCode ?? "", countryCode.code ?? "");
                      },
                      title: "Manager Phone Number".tr,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: CustomTextField(
                      validator: ValidationUtils.validateLengthRange(
                          "Description Of Services", 20,
                          maxLength: 1000),
                      controller: controller.descriptionOfServiceController,
                      maxLine: 5,
                      hintText: "Enter Description".tr,
                      title: "Description Of Services".tr),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: MyCustomButton(
                      title: "Continue".tr,
                      onTap: () {
                        if (_formKey.currentState!.validate() &&
                                controller.validateManagerPhoneNumber() &&
                                controller.verifyMessage.value ==
                                    "Success" //Change to =="Success"
                            ) {
                          Get.to(const SellerFirstGeneralInfo());
                        } else {
                          if (!controller.validatePhoneNumber()) {
                            ShortMessageUtils.showError(
                                "Please enter valid phone number");
                          } else if (!controller.validateManagerPhoneNumber()) {
                            ShortMessageUtils.showError(
                                "Please enter valid manager phone number");
                          }
                          if (controller.verifyMessage.value != "Success") {
                            ShortMessageUtils.showError(
                                "Please verify your phone first");
                          } else {
                            ShortMessageUtils.showError(
                                "Please Fill all fields");
                          }
                          // Get.to(const SellerFirstGeneralInfo());
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
