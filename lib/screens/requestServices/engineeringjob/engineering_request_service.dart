import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/widgets/image_pick_widget.dart';
import 'package:meter/widgets/text_field_country_picker.dart';

import '../../../constant.dart';
import '../../../constant/errorUtills/image_utils.dart';
import '../../../constant/res/app_color/app_color.dart';
import '../../../constant/validationUtils/validation_utils.dart';
import '../../../controller/services/engineering_request_service_controller.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_header.dart';
import '../../../widgets/custom_loading.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/text_widget.dart';
import '../../signup/seller/general_info_2.dart';

class EngineeringRequestService extends StatelessWidget {
  const EngineeringRequestService({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EngineeringRequestServiceController>();
    final _formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const CustomHeader(
                  title: "Request a service",
                  showProgress: true,
                  progressWidth: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      CustomTextField(
                          validator: ValidationUtils.validateRequired(
                              "Preferred city work in"),
                          hintText: "Enter city Name",
                          title: "Preferred city work in",
                          controller: controller.cityController),
                      CustomTextField(
                          hintText: "Enter email",
                          title: "Email",
                          richText: "(Optional)",
                          controller: controller.emailController),
                      CustomTextField(
                          validator: ValidationUtils.validateRequired("Name"),
                          hintText: "Enter name",
                          title: "Name",
                          controller: controller.nameController),
                      Obx(
                        () => TextFieldCountryPicker(
                          hintText: "115203867",
                          controller: controller.phoneNumberController,
                          flagPath: controller.flagUri.value,
                          countryCode: (CountryCode countryCode) {
                            controller.onChangeFlag(
                                countryCode.flagUri ?? "",
                                countryCode.dialCode ?? "",
                                countryCode.code ?? "");
                          },
                          title: "Phone Number".tr,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Obx(
                        () => ImagePickWidget(
                          title: "Click to upload",
                          onTap: () {
                            ImageUtil.pickAndUpdateFile(
                                controller.fileName, controller.filePath);
                          },
                          fileName: controller.fileName.value,
                          isFile: controller.filePath.value != "",
                        ),
                      ),
                      SizedBox(height: Get.height * 0.04),
                      Obx(() => checkBoxWithTitle(
                            controller.isPayMeterChecked.value,
                            const TextWidget(
                                title:
                                    "Commitment to pay Meter application dues",
                                textColor: AppColor.semiTransparentDarkGrey,
                                textAlign: TextAlign.start,
                                fontSize: 14),
                            (newValue) => controller.togglePayMeter(newValue),
                          )),
                      Obx(() => checkBoxWithTitle(
                            controller.isAccuracyChecked.value,
                            const TextWidget(
                              title:
                                  "Commitment to the accuracy of information.",
                              textColor: AppColor.semiTransparentDarkGrey,
                              fontSize: 14,
                              textAlign: TextAlign.start,
                            ),
                            (newValue) =>
                                controller.toggleAccuracyChecked(newValue),
                          )),
                      Obx(() => checkBoxWithTitle(
                            controller.isAgreeTermsChecked.value,
                            RichText(
                              text: TextSpan(
                                style: AppTextStyle.dark14,
                                children: [
                                  TextSpan(text: 'Agree to the '.tr),
                                  TextSpan(
                                    text: 'privacy policy & terms'.tr,
                                    style: AppTextStyle.dark14
                                        .copyWith(color: AppColor.primaryColor),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        log('Navigate to terms & conditions');
                                      },
                                  ),
                                  TextSpan(text: ' ${"of service"}'.tr),
                                ],
                              ),
                            ),
                            (newValue) => controller.toggleAgreeTerms(newValue),
                          )),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Obx(() => controller.isLoading.value
                          ? const CustomLoading()
                          : CustomButton(
                              title: "Submit Request",
                              onTap: () {
                                controller.completeEngineeringJob(_formKey);

                                // Get.to(const EngineeringSpecialization());
                              }))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
