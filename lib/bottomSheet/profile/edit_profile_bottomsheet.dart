import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant/errorUtills/image_utils.dart';
import 'package:meter/constant/validationUtils/validation_utils.dart';
import 'package:meter/widgets/custom_loading.dart';
import 'package:meter/widgets/text_field_country_picker.dart';

import '../../constant/prefUtils/message_utills.dart';
import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../controller/account/edit_account_controller.dart';
import '../../controller/auth/seller_auth_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/text_widget.dart';

class EditProfileBottomSheet extends StatelessWidget {
  const EditProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditAccountController>();
    // final authController = Get.find<SellerAuthController>();
    final authController = Get.put(SellerAuthController());
    final formKey = GlobalKey<FormState>();
    controller.fetchAllValue();
    return Container(
      height: Get.height * 0.87,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: TextWidget(
                      title: "Change User Information".tr,
                      textColor: AppColor.semiDarkGrey,
                      fontSize: 18),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Obx(() => GestureDetector(
                      onTap: () {
                        // Replace with your image picking logic
                        ImageUtil.pickAndUpdateImage(controller.imagePath);
                      },
                      child: ClipOval(
                        child: SizedBox(
                          width: Get.width * 0.30,
                          height: Get.width *
                              0.30, // Ensure width and height are the same for a circular shape
                          child: controller.imagePath.value != ""
                              ? Image.file(File(controller.imagePath.value),
                                  fit: BoxFit.cover)
                              : controller.imageUrl.value != ""
                                  ? Image.network(controller.imageUrl.value,
                                      fit: BoxFit.cover)
                                  : Image.asset(
                                      AppImage.editImage,
                                      width: Get.width * 0.30,
                                      fit: BoxFit.cover,
                                    ),
                        ),
                      ),
                    )),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                CustomTextField(
                    validator: ValidationUtils.validateRequired("Name"),
                    controller: controller.nameController,
                    hintText: "Enter Your Name".tr,
                    title: "Name".tr),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                CustomTextField(
                    validator: ValidationUtils.validateEmail,
                    controller: controller.emailController,
                    hintText: "test123@gmail.com",
                    title: "Email".tr),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Obx(
                      () => TextFieldCountryPicker(
                    isVerifySucces: authController.verifyMessage.value ==
                        "Success", //change to == "Success"
                    hintText: "115203867".tr,
                    controller: authController.phoneNumberController,
                    flagPath: authController.phoneNumberFlagUri.value,
                    countryShortCode: authController.phoneNumberCountryCode.value,
                    countryCode: (CountryCode countryCode) {
                      authController.onChangePhoneNumberFlag(
                          countryCode.flagUri ?? "",
                          countryCode.dialCode ?? "",
                          countryCode.code ?? "");
                    },
                    onTapSuffix: () {
                      if (authController.verifyMessage.value == "Success") {
                        ShortMessageUtils.showSuccess("Already verified");
                      } else if (authController.sendOtpLoading.value) {
                      } else {
                        authController.sendOtp();
                      }
                    },
                    verifyColor: authController.verifyMessage.value == "Success"
                        ? AppColor.semiTransparentDarkGrey
                        : AppColor.primaryColor,
                    verifyText: authController.sendOtpLoading.value
                        ? "Loading..."
                        : (authController.verifyMessage.value == "Success"
                        ? authController.verifyMessage.value
                        : "Verify"),
                    title: "Phone Number".tr,
                  ),
                ),
                // Obx(
                //   () => TextFieldCountryPicker(
                //     hintText: "115203867",
                //     controller: controller.phoneNumberController,
                //     flagPath: controller.flagUri.value,
                //     countryCode: (CountryCode countryCode) {
                //       controller.onChangeFlag(countryCode.flagUri ?? "",
                //           countryCode.dialCode ?? "", countryCode.code ?? "");
                //     },
                //     title: "Phone Number".tr,
                //   ),
                // ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        validator: ValidationUtils.validateRequired("City"),
                        controller: controller.cityController,
                        // readOnly: true,
                        title: "City".tr,
                        hintText: "Select".tr,
                        // onChangeDropDown: (newValue) {},
                        // dropDownItems: const [
                        //   "Riyadh",
                        //   "Jeddah",
                        //   "Mecca",
                        //   "Medina"
                        // ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomTextField(
                        validator:
                            ValidationUtils.validateRequired("Neighborhood"),
                        controller: controller.neighborhoodController,
                        title: "Neighborhood".tr,
                        hintText: "Select".tr,
                        // readOnly: true,
                        // onChangeDropDown: (newValue) {},
                        // dropDownItems: const [
                        //   "Riyadh",
                        //   "Jeddah",
                        //   "Mecca",
                        //   "Medina"
                        // ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Obx(() => controller.isLoading.value
                    ? const CustomLoading()
                    : Row(
                        children: [
                          Expanded(
                              child: MyCustomButton(
                            title: "Cancel".tr,
                            textColor: AppColor.semiTransparentDarkGrey,
                            backgroundColor: Colors.transparent,
                            onTap: () {
                              Get.back();
                            },
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: CustomButton(
                                  title: "Save".tr,
                                  onTap: () {
                                    controller.updateProfile(formKey);
                                  }))
                        ],
                      ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
