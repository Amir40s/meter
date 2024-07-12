import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant/errorUtills/image_utils.dart';
import 'package:meter/constant/res/app_images/app_images.dart';
import 'package:meter/constant/routes/routes_name.dart';
import 'package:meter/constant/validationUtils/validation_utils.dart';
import 'package:meter/widgets/custom_header.dart';
import 'package:meter/widgets/custom_textfield.dart';
import 'package:meter/widgets/image_pick_widget.dart';
import 'package:meter/widgets/text_field_country_picker.dart';

import '../../../constant/prefUtils/message_utills.dart';
import '../../../constant/res/app_color/app_color.dart';
import '../../../controller/auth/provider_auth_controller.dart';
import '../../../widgets/custom_button.dart';

class ProviderGeneralInfo extends StatelessWidget {
  const ProviderGeneralInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProviderAuthController>();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        bottomNavigationBar: Container(
          height: Get.height * 0.08,
          margin: const EdgeInsets.only(bottom: 10, left: 14, right: 14),
          child: MyCustomButton(
              title: "Continue".tr,
              onTap: () {
                if (_formKey.currentState!.validate() &&
                        controller.filePath.isNotEmpty &&
                        controller.verifyMessage.value ==
                            "Success" //Change to =="Success"
                    ) {
                  Get.toNamed(RoutesName.providerFirstGeneralInfo);
                } else {
                  if (controller.verifyMessage.value != "Success") {
                    ShortMessageUtils.showError(
                        "Please verify your phone number");
                  } else if (controller.filePath.value.isEmpty) {
                    ShortMessageUtils.showError("Please upload your papers");
                  } else if (controller.verifyMessage.value != "Success") {
                    ShortMessageUtils.showError("Please verify first");
                  } else {
                    ShortMessageUtils.showError("Please fill all fields");
                  }
                }
              }),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomHeader(
                  showProgress: true,
                  title: "General Info".tr,
                  progressWidth: 2.3,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 14.0, right: 14, top: 14.0),
                  child: CustomTextField(
                      validator:
                          ValidationUtils.validateRequired("The Owner Name"),
                      controller: controller.ownerNameController,
                      hintText: "Enter owner name",
                      title: "The Owner Name".tr),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: Obx(
                    () => TextFieldCountryPicker(
                      isVerifySucces: controller.verifyMessage.value ==
                          "Success", //"Success"  change when deliver to client
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
                  padding:
                      const EdgeInsets.only(left: 14.0, right: 14, top: 14.0),
                  child: CustomTextField(
                      validator: ValidationUtils.validateRequired(
                          "Commercial Registration"),
                      controller: controller.commercialRegistrationController,
                      hintText: "12345678786hgg",
                      title: "Commercial Registration".tr),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 14.0, right: 14, top: 14.0),
                  child: CustomTextField(
                      onTap: () {
                        controller.pickCommercialRegistrationDate(context);
                      },
                      validator: ValidationUtils.validateRequired(
                          "Date of commercial registration"),
                      controller:
                          controller.dateOfCommercialRegistrationController,
                      prefixImagePath: AppImage.calender,
                      readOnly: true,
                      textInputType: TextInputType.number,
                      hintText: "2024/13/13",
                      title: "Date of commercial registration".tr),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Obx(
                  () => Padding(
                    padding: EdgeInsets.only(left: 14.0, right: 14),
                    child: ImagePickWidget(
                        onTap: () {
                          ImageUtil.pickAndUpdateFile(
                              controller.fileName, controller.filePath);
                        },
                        fileName: controller.fileName.value,
                        isFile: controller.filePath.value != "",
                        title: "Click to upload \n your papers"),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
