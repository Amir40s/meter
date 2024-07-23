import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/prefUtils/message_utills.dart';
import '../../constant/res/app_color/app_color.dart';
import '../../constant/routes/routes_name.dart';
import '../../constant/validationUtils/validation_utils.dart';
import '../../controller/device/adddevice_controller.dart';
import '../../model/devices/devices_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_linear_progress.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/radio/group_raadio_widget.dart';
import '../../widgets/text_widget.dart';

class PublishDevice extends StatelessWidget {
  final bool isUpdate;
  final DeviceModel? deviceModel;
  const PublishDevice({super.key, required this.isUpdate, this.deviceModel});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PublishDeviceController());
    if (deviceModel != null) {
      controller.editInitialization(isUpdate, deviceModel!);
    }
    final _formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
            height: Get.height * 0.08,
            margin: const EdgeInsets.only(bottom: 10, left: 14, right: 14),
            child: CustomButton(
                title: "Continue".tr,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    Get.toNamed(RoutesName.publishFirstDevice, arguments: {
                      "isUpdate": isUpdate,
                      "deviceModel": deviceModel
                    });
                  } else {
                    ShortMessageUtils.showError("Please enter all fields");
                  }
                  // Get.toNamed(RoutesName.publishFirstDevice);
                })),
        body: Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Transform.translate(
                      offset: const Offset(-16, 2),
                      child: CustomHeader(
                          title: isUpdate
                              ? "Edit a device"
                              : "Publish a device".tr)),
                  Transform.translate(
                      offset: const Offset(0, -10),
                      child: const CustomLinearProgress(value: 0.42)),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  const TextWidget(
                    title: "Type of device",
                    textColor: AppColor.semiDarkGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),

                  Transform.translate(
                    offset: const Offset(-13, 0),
                    child: Row(
                      children: [
                        Obx(() => rowWithRadio(
                              'Buy'.tr,
                              controller.selectedOption.value,
                              'Buy',
                              (newValue) => controller.selectOption(newValue!),
                            )),
                        Obx(() => rowWithRadio(
                              'Sell'.tr,
                              controller.selectedOption.value,
                              'Sell',
                              (newValue) => controller.selectOption(newValue!),
                            )),
                        Obx(() => rowWithRadio(
                              'Rent'.tr,
                              controller.selectedOption.value,
                              'Rent',
                              (newValue) => controller.selectOption(newValue!),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  CustomTextField(
                      validator:
                          ValidationUtils.validateRequired("Device Name"),
                      controller: controller.deviceNameController,
                      hintText: "Enter device name".tr,
                      title: "Device Name".tr),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  CustomTextField(
                    validator:
                        ValidationUtils.validateRequired("Device Category"),
                    controller: controller.deviceCategoryController,
                    hintText: "Choose device category".tr,
                    title: "Device Category".tr,
                    readOnly: false,
                    // dropDownItems: controller.deviceCategory.value,
                    // onChangeDropDown: (newValue) {
                    //   controller.onChangeDropDown(newValue);
                    // },
                  ),

                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  CustomTextField(
                      validator: ValidationUtils.validateRequired("Model"),
                      controller: controller.modelController,
                      hintText: "Enter Model".tr,
                      title: "Model".tr),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  CustomTextField(
                    validator:
                        ValidationUtils.validateRequired("Manufacturing Year"),
                    controller: controller.manufacturingYearController,
                    hintText: "Enter Manufacturing Year".tr,
                    title: "Manufacturing Year".tr,
                    textInputType: TextInputType.number,
                  ),
                  // SizedBox(
                  //   height: Get.height * 0.02,
                  // ),
                  // CustomTextField(
                  //   controller: controller.manufacturerController,
                  //   hintText: "Enter Manufacturer".tr,
                  //   title: "Manufacturer".tr,
                  // ),
                  // SizedBox(
                  //   height: Get.height * 0.02,
                  // ),
                  // CustomTextField(
                  //   controller: controller.industryController,
                  //   prefixImagePath: AppImage.flag,
                  //   hintText: "Egypt",
                  //   title: "Industy Country".tr,
                  //   readOnly: true,
                  //   onChangeDropDown: (newValue) {},
                  //   dropDownItems: ["Egypt", "Saudi Arabia"],
                  // ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
