import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant/res/app_color/app_color.dart';
import 'package:meter/constant/res/app_images/app_images.dart';
import 'package:meter/controller/provider_controller/send_work/delevering_service_controller.dart';
import 'package:meter/widgets/custom_button.dart';
import 'package:meter/widgets/text_widget.dart';

import '../../../../constant/validationUtils/validation_utils.dart';
import '../../../../widgets/custom_header.dart';
import '../../../../widgets/custom_textfield.dart';
import '../../../../widgets/radio/group_raadio_widget.dart';
import 'delivering_service1.dart';

class DeliveringServiceMain extends StatelessWidget {
  const DeliveringServiceMain({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DeliveringServiceController());
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          height: Get.height * 0.08,
          margin: const EdgeInsets.only(bottom: 10, left: 14, right: 14),
          child: MyCustomButton(
              title: "Continue".tr,
              onTap: () {
                Get.to(const DeliveringFirstService());
              }),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const CustomHeader(
                title: "Delivering Service",
                showProgress: true,
                progressWidth: 2,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                        validator:
                            ValidationUtils.validateRequired("Service Type"),
                        controller: controller.serviceTypeController,
                        readOnly: true,
                        onChangeDropDown: (newValue) {
                          controller.onChangeServiceType(newValue);
                        },
                        dropDownItems: [
                          "Faisalbad".tr,
                          "Multan".tr,
                        ],
                        hintText: "Service Type".tr,
                        title: "Choose Service Type".tr),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    const TextWidget(
                      title: "Type of certificate",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      textColor: AppColor.semiDarkGrey,
                    ),
                    Obx(
                      () => Transform.translate(
                        offset: Offset(-Get.width * 0.046, 0),
                        child: Row(
                          children: [
                            rowWithRadio(
                              fontSize: 12,
                              "Residential",
                              controller.selectedTypeOfCertificate.value,
                              "Residential",
                              (newValue) => controller
                                  .selectedTypeOfCertificate(newValue!),
                            ),
                            rowWithRadio(
                              fontSize: 12,
                              "Commercial",
                              controller.selectedTypeOfCertificate.value,
                              "Commercial",
                              (newValue) => controller
                                  .selectedTypeOfCertificate(newValue),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () => Transform.translate(
                        offset: Offset(-Get.width * 0.046, -Get.width * 0.04),
                        child: Row(
                          children: [
                            rowWithRadio(
                              fontSize: 12,
                              "Governmental",
                              controller.selectedTypeOfCertificate.value,
                              "Governmental",
                              (newValue) => controller
                                  .selectedTypeOfCertificate(newValue!),
                            ),
                            rowWithRadio(
                              fontSize: 12,
                              "Investment",
                              controller.selectedTypeOfCertificate.value,
                              "Investment",
                              (newValue) => controller
                                  .selectedTypeOfCertificate(newValue!),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () => Transform.translate(
                        offset: Offset(-Get.width * 0.046, -Get.width * 0.08),
                        child: rowWithRadio(
                          fontSize: 12,
                          "Industrial",
                          controller.selectedTypeOfCertificate.value,
                          "Industrial",
                          (newValue) =>
                              controller.selectedTypeOfCertificate(newValue!),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, -Get.width * 0.14),
                      child: CustomTextField(
                        hintText: "Other",
                        title: "",
                        controller: controller.otherController,
                        showSpace: true,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, -Get.width * 0.10),
                      child: CustomTextField(
                          hintText: "Enter Applicant's name",
                          title: "Applicant's name",
                          controller: controller.applicantNameController),
                    ),
                    Transform.translate(
                      offset: Offset(0, -Get.width * 0.03),
                      child: TextWidget(
                        title: "Applicant Type",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        textColor: AppColor.semiDarkGrey,
                      ),
                    ),
                    Obx(
                      () => Transform.translate(
                        offset: Offset(-Get.width * 0.046, -Get.width * 0.03),
                        child: Row(
                          children: [
                            rowWithRadio(
                              fontSize: 12,
                              "Owner",
                              controller.selectedTypeOfApplicant.value,
                              "Owner",
                              (newValue) =>
                                  controller.typeOfApplicant(newValue!),
                            ),
                            rowWithRadio(
                              fontSize: 12,
                              "Dealer",
                              controller.selectedTypeOfApplicant.value,
                              "Commercial",
                              (newValue) =>
                                  controller.typeOfApplicant(newValue!),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, -Get.width * 0.06),
                      child: CustomTextField(
                          hintText: "Agency number",
                          title: "",
                          showSpace: true,
                          textInputType: TextInputType.number,
                          controller: controller.agencyNumberController),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Transform.translate(
                      offset: Offset(0, -Get.width * 0.10),
                      child: CustomTextField(
                          hintText: "Enter Id number",
                          title: "ID number",
                          textInputType: TextInputType.number,
                          controller: controller.idNumberController),
                    ),
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
