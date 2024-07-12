import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant/res/app_color/app_color.dart';
import 'package:meter/controller/auth/provider_auth_controller.dart';
import 'package:meter/screens/signup/provider/provider_general_info.dart';
import 'package:meter/widgets/custom_textfield.dart';
import 'package:meter/widgets/radio/group_raadio_widget.dart';
import 'package:meter/widgets/text_widget.dart';

import '../../../constant/prefUtils/message_utills.dart';
import '../../../constant/res/app_images/app_images.dart';
import '../../../constant/validationUtils/validation_utils.dart';
import '../../../widgets/custom_button.dart';

class ProviderLoginMain extends StatelessWidget {
  const ProviderLoginMain({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProviderAuthController());
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * 0.04,
          ),
          TextWidget(
            title: "Service Provider",
            textColor: AppColor.semiDarkGrey,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Transform.translate(
            offset: Offset(-13, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => rowWithRadio(
                      'Company'.tr,
                      controller.selectedProviderServiceOption.value,
                      'Company',
                      (newValue) =>
                          controller.selectProviderServiceOption(newValue!),
                      fontSize: 12,
                    )),
                Obx(() => rowWithRadio(
                      'Establishment'.tr,
                      controller.selectedProviderServiceOption.value,
                      'Establishment',
                      (newValue) =>
                          controller.selectProviderServiceOption(newValue!),
                      fontSize: 12,
                    )),
                Obx(() => rowWithRadio(
                      'Office'.tr,
                      controller.selectedProviderServiceOption.value,
                      'Office',
                      (newValue) =>
                          controller.selectProviderServiceOption(newValue!),
                      fontSize: 12,
                    )),
              ],
            ),
          ),
          CustomTextField(
            validator: ValidationUtils.validateRequired("Facility name"),
            controller: controller.facilityNameController,
            hintText: "Enter facility name",
            title: "Facility name".tr,
          ),
          CustomTextField(
            validator: ValidationUtils.validateRequired("Type Of Activity"),
            controller: controller.typeOfActivityController,
            hintText: "Engineering Office".tr,
            title: "Type Of Activity".tr,
            onChangeDropDown: (newValue) {
              controller.onChangeActivity(newValue);
            },
            readOnly: true,
            dropDownItems: [
              "Office1".tr,
              "Office2".tr,
            ],
            prefixImagePath: AppImage.user,
          ),
          CustomTextField(
            validator: ValidationUtils.validateRequired("License Number"),
            controller: controller.licenseNumberController,
            hintText: "Enter License Number",
            title: "License Number".tr,
          ),
          CustomTextField(
            validator: ValidationUtils.validateLengthRange(
                "Description Of Service", 10),
            hintText: "Write Description".tr,
            controller: controller.descriptionOfServiceController,
            title: "Description Of Service".tr,
            maxLine: 5,
          ),
          SizedBox(
            height: Get.height * 0.03,
          ),
          MyCustomButton(
              title: "Register".tr,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  Get.to(const ProviderGeneralInfo());
                } else {
                  ShortMessageUtils.showError("Please Fill all fields");
                }
                // Get.to(const ProviderGeneralInfo());
              })
        ],
      ),
    );
  }
}
