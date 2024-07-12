import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/controller/provider_controller/send_work/send_work_controller.dart';
import 'package:meter/screens/send_work/send_work_2.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_header.dart';
import '../../../widgets/custom_textfield.dart';

class SendFirstWork extends StatelessWidget {
  const SendFirstWork({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SendWorkController>();
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
                    Get.to(SendSecondWork());
                    // Get.to(const ProviderSecondGeneralInfo());
                  }),
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomHeader(
                title: "Send Work",
                showProgress: true,
                progressWidth: 1.6,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    CustomTextField(
                        hintText: "Enter Piece Number",
                        title: "Piece Number",
                        textInputType: TextInputType.number,
                        controller: controller.pieceNumberController),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    CustomTextField(
                        hintText: "Enter Chart number",
                        title: "Chart number",
                        richText: "(Optional)",
                        textInputType: TextInputType.number,
                        controller: controller.chartNumberController),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                              hintText: "Enter Region",
                              title: "Region",
                              controller: controller.regionController),
                        ),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Expanded(
                          child: CustomTextField(
                              hintText: "Enter City",
                              title: "City",
                              richText: "(Optional)",
                              controller: controller.cityController),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    CustomTextField(
                        hintText: "Enter Neighborhood",
                        title: "Neighborhood",
                        richText: "(Optional)",
                        controller: controller.neighborhoodController),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    CustomTextField(
                        hintText: "Enter street name",
                        title: "Street Name",
                        controller: controller.streetController)
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
