import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/res/app_color/app_color.dart';
import '../../../constant/validationUtils/validation_utils.dart';
import '../../../controller/services/engineering_request_service_controller.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/radio/group_raadio_widget.dart';
import '../../../widgets/text_widget.dart';
import 'engineering_specialization.dart';

class EngineeringJob extends StatelessWidget {
  const EngineeringJob({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EngineeringRequestServiceController());
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Form(
        key: controller.engineeringJobFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
                title: "Type Of Certificate",
                textColor: AppColor.semiDarkGrey,
                fontSize: 16),
            Obx(
              () => Transform.translate(
                offset: Offset(-Get.width * 0.046, 0),
                child: Row(
                  children: [
                    rowWithRadio(
                      fontSize: 14,
                      "University Degree",
                      controller.selectedTypeOfCertificate.value,
                      "University Degree",
                      (newValue) =>
                          controller.selectTypeOfCertificate(newValue!),
                    ),
                    Obx(
                      () => rowWithRadio(
                        fontSize: 14,
                        "Diploma",
                        controller.selectedTypeOfCertificate.value,
                        "Diploma",
                        (newValue) =>
                            controller.selectTypeOfCertificate(newValue!),
                      ),
                    )
                  ],
                ),
              ),
            ),
            CustomTextField(
              hintText: "Other",
              title: "",
              showSpace: true,
              onChanged: (newValue) {
                controller.onChangeOtherValue(newValue);
              },
              controller: controller.otherController,
              validator: (value) {
                if (controller.isOtherRequired.value && value!.isEmpty) {
                  return 'This field is required if no certificate is selected';
                }
                return null;
              },
            ),

            SizedBox(
              height: Get.height * 0.02,
            ),
            CustomTextField(
              validator: ValidationUtils.validateRequired("Specialization"),
              hintText: "Choose Your Specialization",
              title: "Specialization",
              controller: controller.specialistController,
              readOnly: true,
              onTap: () {
                Get.bottomSheet(EngineeringSpecialization(),
                    isScrollControlled: true);
              },
              dropDownItems: const [],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            const TextWidget(
                title: "Do you have experience",
                textColor: AppColor.semiDarkGrey,
                fontSize: 16),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Obx(
              () => Transform.translate(
                offset: Offset(-Get.width * 0.046, 0),
                child: Row(
                  children: [
                    rowWithRadio(
                      fontSize: 14,
                      "Yes",
                      controller.selectedExperience.value,
                      "Yes",
                      (newValue) => controller.selectExperience(newValue!),
                    ),
                    SizedBox(
                      height: Get.width * 0.10,
                    ),
                    rowWithRadio(
                      fontSize: 14,
                      "No",
                      controller.selectedExperience.value,
                      "No",
                      (newValue) => controller.selectExperience(newValue!),
                    ),
                  ],
                ),
              ),
            ),
            CustomTextField(
                validator: (value) {
                  if (controller.selectedExperience.value == "Yes" &&
                      (value == null || value.isEmpty)) {
                    return "Experience is required";
                  }
                  return null;
                },
                maxLine: 4,
                hintText: "If yes, write experience here",
                title: "",
                showSpace: false,
                controller: controller.experienceController),
            SizedBox(
              height: Get.height * 0.02,
            ),
            // CustomButton(
            //     title: "Continue",
            //     onTap: () {
            //       Get.to(EngineeringRequestService());
            //     })
          ],
        ),
      ),
    );
  }
}
