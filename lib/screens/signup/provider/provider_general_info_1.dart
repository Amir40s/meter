import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant/prefUtils/message_utills.dart';
import 'package:meter/constant/res/app_color/app_color.dart';
import 'package:meter/constant/res/app_images/app_images.dart';
import 'package:meter/constant/routes/routes_name.dart';
import 'package:meter/constant/validationUtils/validation_utils.dart';
import 'package:meter/controller/auth/provider_auth_controller.dart';
import 'package:meter/widgets/custom_button.dart';
import 'package:meter/widgets/custom_header.dart';
import 'package:meter/widgets/custom_textfield.dart';
import 'package:meter/widgets/text_field_country_picker.dart';

class ProviderFirstGeneralInfo extends StatelessWidget {
  const ProviderFirstGeneralInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProviderAuthController>();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        bottomNavigationBar: Container(
            height: Get.height * 0.08,
            margin: EdgeInsets.only(bottom: 10, left: 14, right: 14),
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14),
              child: MyCustomButton(
                  title: "Continue".tr,
                  onTap: () {
                    if (_formKey.currentState!.validate() &&
                        controller.validateManagerPhoneNumber()) {
                      Get.toNamed(RoutesName.providerSecondGeneralInfo);
                    } else {
                      if (!controller.validateManagerPhoneNumber()) {
                        ShortMessageUtils.showError(
                            "Please enter valid manager phone number");
                      } else {
                        ShortMessageUtils.showError("Please fill all fields");
                      }
                    }
                  }),
            )),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomHeader(
                  showProgress: true,
                  title: "General Info".tr,
                  progressWidth: 2,
                ),
                SizedBox(
                  height: Get.height * 0.02,
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
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: Obx(
                    () => TextFieldCountryPicker(
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
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                            validator:
                                ValidationUtils.validateRequired("Region"),
                            controller: controller.regionController,
                            hintText: "Enter Region".tr,
                            title: "Region".tr),
                      ),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                      Expanded(
                        child: CustomTextField(
                          controller: controller.cityController,
                          hintText: "Enter City".tr,
                          title: "City".tr,
                          richText: "(Optional)",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: CustomTextField(
                      controller: controller.neighborhoodController,
                      richText: "(Optional)",
                      hintText: "Enter Neighborhood".tr,
                      title: "Neighborhood".tr),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: CustomTextField(
                    validator: ValidationUtils.validateRequired("Location"),
                    controller: controller.locationController,
                    hintText: "Location".tr,
                    title: "Location".tr,
                    prefixImagePath: AppImage.location,
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
