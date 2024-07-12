import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant/errorUtills/image_utils.dart';
import 'package:meter/constant/prefUtils/message_utills.dart';
import 'package:meter/constant/res/app_color/app_color.dart';
import 'package:meter/constant/routes/routes_name.dart';
import 'package:meter/constant/validationUtils/validation_utils.dart';
import 'package:meter/controller/auth/seller_auth_controller.dart';
import 'package:meter/widgets/custom_button.dart';
import 'package:meter/widgets/custom_header.dart';

import '../../../constant/res/app_images/app_images.dart';
import '../../../widgets/custom_textfield.dart';

class SellerFirstGeneralInfo extends StatelessWidget {
  const SellerFirstGeneralInfo({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeader(
                  showProgress: true,
                  title: "General Info".tr,
                  progressWidth: 1.7,
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Obx(() => Padding(
                      padding: const EdgeInsets.all(14.0),
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
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: CustomTextField(
                      validator: ValidationUtils.validateRequired("Region"),
                      controller: controller.regionController,
                      hintText: "Enter Region".tr,
                      title: "Region".tr),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: CustomTextField(
                    validator: ValidationUtils.validateRequired("City"),
                    // onChangeDropDown: (newValue) {
                    //   controller.onChangeCity(newValue);
                    // },
                    // readOnly: true,
                    // dropDownItems: controller.cities,
                    hintText: "Select City".tr,
                    title: "City".tr,
                    controller: controller.cityController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: CustomTextField(
                      validator:
                          ValidationUtils.validateRequired("Neighborhood"),
                      // onChangeDropDown: (newValue) {
                      //   controller.onChangeNeighborhood(newValue);
                      // },
                      // onTap: () {
                      //   log("Neifhbors are ${controller.neighborhoods}");
                      // },
                      // readOnly: true,
                      controller: controller.neighborhoodController,
                      // dropDownItems: controller.neighborhoods,
                      hintText: "Select Neighborhood".tr,
                      title: "Neighborhood".tr),
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
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: MyCustomButton(
                      title: "Continue".tr,
                      onTap: () {
                        if (_formKey.currentState!.validate() &&
                            controller.imagePath.value != "") {
                          Get.toNamed(RoutesName.sellerSecondGeneralInfo);
                        } else {
                          if (controller.imagePath.value == "") {
                            ShortMessageUtils.showError(
                                "Please pick image first");
                          } else {
                            ShortMessageUtils.showError(
                                "Please fill all fields");
                          }
                          // Get.to(const SellerSecondGeneralInfo());
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
