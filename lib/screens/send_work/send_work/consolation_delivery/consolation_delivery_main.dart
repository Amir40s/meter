import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant/res/app_color/app_color.dart';
import 'package:meter/controller/provider_controller/send_work/consolation_delivery_controller.dart';
import 'package:meter/widgets/custom_textfield.dart';
import 'package:meter/widgets/radio/group_raadio_widget.dart';
import 'package:meter/widgets/text_widget.dart';

import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_header.dart';
import 'consolation_delivery1.dart';


class ConsolationDeliveryMain extends StatelessWidget {
  const ConsolationDeliveryMain({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ConsolationDeliveryController());
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
            height: Get.height * 0.08,
            margin: const EdgeInsets.only(bottom: 10, left: 14, right: 14),
            child: CustomButton(
                title: "Continue",
                onTap: () {
                  Get.to(ConsolationFirstDelivery());
                })),
        body: Column(
          children: [
            CustomHeader(
              title: "Consolation delivery",
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
                      hintText: "Enter consolation title",
                      title: "Consolation title",
                      controller: controller.consultationTitleController),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  TextWidget(
                    title: "Consolation type",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    textColor: AppColor.semiDarkGrey,
                  ),
                  Obx(
                    () => Transform.translate(
                      offset: Offset(-Get.width * 0.046, 0),
                      child: Row(
                        children: [
                          rowWithRadio(
                            fontSize: 12,
                            "Real estate",
                            controller.selectedConsolationType.value,
                            "Real estate",
                            (newValue) =>
                                controller.typeOfConsolation(newValue!),
                          ),
                          rowWithRadio(
                            fontSize: 12,
                            "Engineering",
                            controller.selectedConsolationType.value,
                            "Engineering",
                            (newValue) =>
                                controller.typeOfConsolation(newValue!),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomTextField(
                      hintText: "Write consolation details",
                      title: "Consolation",
                      maxLine: 4,
                      controller: controller.consultationController),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  CustomTextField(
                      hintText: "Enter Applicant's name",
                      title: "Applicant's name",
                      controller: controller.applicantNameController),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
