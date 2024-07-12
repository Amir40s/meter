import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant/prefUtils/message_utills.dart';
import 'package:meter/constant/res/app_images/app_images.dart';
import 'package:meter/controller/auth/customer_auth_controller.dart';
import 'package:meter/screens/signup/customer/customer_general_info_1.dart';
import 'package:meter/widgets/custom_button.dart';
import '../../../constant/errorUtills/image_utils.dart';
import '../../../constant/res/app_color/app_color.dart';
import '../../../constant/validationUtils/validation_utils.dart';
import '../../../widgets/custom_header.dart';
import '../../../widgets/custom_textfield.dart';

class CustomerGeneralInfo extends StatelessWidget {
  const CustomerGeneralInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomerAuthController>();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeader(
                  showProgress: true,
                  title: "General Info".tr,
                  progressWidth: 1.5,
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Obx(
                  () => GestureDetector(
                      onTap: () {
                        ImageUtil.pickAndUpdateImage(controller.imagePath);
                      },
                      child: controller.imagePath.value == ""
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 14.0, right: 14),
                              child: Image.asset(
                                AppImage.pickImage,
                                height: Get.height * 0.17,
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.only(left: 14.0, right: 14),
                              child: ClipOval(
                                child: Image.file(
                                  File(controller.imagePath.value),
                                  height: Get.height * 0.17,
                                  width: Get.height *
                                      0.17, // Ensure the width is the same as the height for a circle
                                  fit: BoxFit
                                      .cover, // This will ensure the image covers the circle completely
                                ),
                              ),
                            )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: CustomTextField(
                    validator: ValidationUtils.validateRequired("Address"),
                    hintText: "Enter Address".tr,
                    title: "Address".tr,
                    controller: controller.addressController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: CustomTextField(
                      validator: ValidationUtils.validateRequired("City"),
                      controller: controller.cityController,
                      // readOnly: true,
                      // onChangeDropDown: (newValue) {
                      //   controller.onChangeCity(newValue);
                      // },
                      // dropDownItems: controller.cities,
                      hintText: "Select City".tr,
                      title: "City".tr),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: CustomTextField(
                      validator:
                          ValidationUtils.validateRequired("Neighborhood"),
                      controller: controller.neighborhoodController,
                      // onChangeDropDown: (newValue) {
                      //   controller.onChangeNeighborhood(newValue);
                      // },
                      // readOnly: true,
                      // dropDownItems: controller.neighborhoods,
                      hintText: "Select Neighborhood".tr,
                      title: "Neighborhood".tr),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: MyCustomButton(
                      title: "Continue".tr,
                      onTap: () {
                        if (_formKey.currentState!.validate() &&
                            controller.imagePath.value != "") {
                          Get.to(const CustomerFirstGeneralInfo());
                        } else {
                          if (controller.imagePath.value == "") {
                            ShortMessageUtils.showError(
                                "Please pick image first");
                          } else {
                            ShortMessageUtils.showError(
                                "Please fill all fields");
                          }
                          // Get.to(const CustomerFirstGeneralInfo());
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
