import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/widgets/image_pick_widget.dart';
import '../../constant.dart';
import '../../constant/errorUtills/image_utils.dart';
import '../../constant/res/app_color/app_color.dart';
import '../../constant/validationUtils/validation_utils.dart';
import '../../controller/device/adddevice_controller.dart';
import '../../model/devices/devices_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_linear_progress.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/text_widget.dart';
import '../signup/seller/general_info_2.dart';

class PublishFirstDevice extends StatelessWidget {
  const PublishFirstDevice({super.key});

  @override
  Widget build(BuildContext context) {
    final PublishDeviceController publishDeviceController =
        Get.find<PublishDeviceController>();
    final arguments = Get.arguments as Map<String, dynamic>;
    bool isUpdate = arguments["isUpdate"];
    DeviceModel? deviceModel;
    if (arguments["deviceModel"] != null) {
      deviceModel = arguments["deviceModel"];
    }
    log("Is Update $isUpdate");
    final _formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Transform.translate(
                      offset: const Offset(-16, 2),
                      child: CustomHeader(
                          title: !isUpdate
                              ? "Publish a device".tr
                              : "Edit a device")),
                  Transform.translate(
                      offset: const Offset(0, -10),
                      child: const CustomLinearProgress(value: 1)),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  CustomTextField(
                    validator: ValidationUtils.validateRequired("Device Price"),
                    controller: publishDeviceController.devicePriceController,
                    hintText: "Enter device price".tr,
                    title: "Device Price".tr,
                    textInputType: TextInputType.number,
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  CustomTextField(
                    validator:
                        ValidationUtils.validateRequired("Write details"),
                    controller: publishDeviceController.detailsController,
                    hintText: "Write details".tr,
                    title: "Details".tr,
                    maxLine: 5,
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Obx(
                    () => ImagePickWidget(
                      imageUrl: publishDeviceController.imageUrl.value,
                      title: "Click to Upload Device Photos",
                      imagePath: publishDeviceController.imagePath.value,
                      onTap: () {
                        log(publishDeviceController.imagePath.value);
                        ImageUtil.pickAndUpdateImage(
                            publishDeviceController.imagePath);
                      },
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  if (!isUpdate) ...[
                    Obx(() => checkBoxWithTitle(
                          publishDeviceController
                              .isSellerAgreeTermsChecked.value,
                          RichText(
                            text: TextSpan(
                              style: AppTextStyle.dark14,
                              children: [
                                TextSpan(text: 'I agree to the '.tr),
                                TextSpan(
                                  text: 'privacy policy & terms'.tr,
                                  style: AppTextStyle.dark14
                                      .copyWith(color: AppColor.primaryColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Handle click event
                                      print('Navigate to terms & conditions');
                                    },
                                ),
                                TextSpan(text: ' of Services'.tr),
                              ],
                            ),
                          ),
                          (newValue) => publishDeviceController
                              .toggleSellerAgreeTerms(newValue),
                        )),
                    // SizedBox(height: Get.height * 0.02),
                    Obx(() => checkBoxWithTitle(
                          publishDeviceController
                              .isSellerAccurateInfoChecked.value,
                          const TextWidget(
                              title:
                                  "Commitment to the accuracy of information.",
                              textColor: AppColor.semiTransparentDarkGrey,
                              textAlign: TextAlign.start,
                              fontSize: 14),
                          (newValue) => publishDeviceController
                              .toggleSellerAccurateInfo(newValue),
                        )),
                    // SizedBox(height: Get.height * 0.02),
                    Obx(() => checkBoxWithTitle(
                          publishDeviceController.isSellerPayDuesChecked.value,
                          const TextWidget(
                            title:
                                "Commitment to pay meter app dues, estimated at 10% of the project value.",
                            textColor: AppColor.semiTransparentDarkGrey,
                            fontSize: 14,
                            textAlign: TextAlign.start,
                          ),
                          (newValue) => publishDeviceController
                              .toggleSellerPayDues(newValue),
                        )),
                  ],
                  SizedBox(
                    height: Get.height * 0.06,
                  ),
                  Obx(() => publishDeviceController.isLoading.value
                      ? const Align(
                          alignment: Alignment.topCenter,
                          child: CustomLoading())
                      : CustomButton(
                          title: "Continue".tr,
                          onTap: () {
                            if (isUpdate && deviceModel != null) {
                              log("Device Model ${deviceModel.deviceModel}");
                              publishDeviceController
                                  .updateDevice(deviceModel.id);
                            } else {
                              publishDeviceController
                                  .publishDeviceClick(_formKey);
                            }
                          })),
                  SizedBox(
                    height: Get.height * 0.02,
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
