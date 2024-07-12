import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/controller/provider_controller/send_work/send_work_controller.dart';
import 'package:meter/screens/send_work/send_work_1.dart';
import 'package:meter/widgets/custom_button.dart';
import 'package:meter/widgets/custom_textfield.dart';
import 'package:meter/widgets/text_field_country_picker.dart';

import '../../constant/res/app_color/app_color.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/radio/group_raadio_widget.dart';
import '../../widgets/text_widget.dart';


class SendWork extends StatelessWidget {
  const SendWork({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SendWorkController());
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
            height: Get.height * 0.08,
            margin: EdgeInsets.only(bottom: 10, left: 14, right: 14),
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14),
              child: MyCustomButton(
                  title: "Continue".tr,
                  onTap: () {
                    log("Click");
                    Get.to(const SendFirstWork());
                  }),
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const CustomHeader(
                title: "Send Work",
                showProgress: true,
                progressWidth: 2.1,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                        hintText: "Enter Applicant's name",
                        title: "Applicant's name",
                        controller: controller.applicantNameController),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    const TextWidget(
                      title: "Applicant Type",
                      fontWeight: FontWeight.bold,
                      textColor: AppColor.semiDarkGrey,
                    ),
                    Transform.translate(
                      offset: const Offset(-13, 0),
                      child: Row(
                        children: [
                          Obx(() => rowWithRadio(
                                'Owner'.tr,
                                controller.selectedApplicantType.value,
                                'Owner',
                                (newValue) =>
                                    controller.selectedApplicant(newValue!),
                              )),
                          Obx(() => rowWithRadio(
                                'Dealer'.tr,
                                controller.selectedApplicantType.value,
                                'Dealer',
                                (newValue) =>
                                    controller.selectedApplicant(newValue!),
                              )),
                        ],
                      ),
                    ),
                    CustomTextField(
                        showSpace: true,
                        hintText: "Agency Number",
                        textInputType: TextInputType.number,
                        title: "",
                        controller: controller.agencyNumberController),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
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
                    CustomTextField(
                        hintText: "Enter Id number",
                        title: "ID number",
                        textInputType: TextInputType.number,
                        controller: controller.idNumberController),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    CustomTextField(
                        hintText: "Enter Instrumental Number",
                        title: "Instrumental Number",
                        textInputType: TextInputType.number,
                        controller: controller.idNumberController)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
