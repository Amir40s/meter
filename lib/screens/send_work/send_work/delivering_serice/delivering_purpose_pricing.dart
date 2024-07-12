import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant/res/app_color/app_color.dart';
import 'package:meter/constant/res/app_images/app_images.dart';
import 'package:meter/controller/provider_controller/send_work/delevering_service_controller.dart';
import 'package:meter/widgets/custom_button.dart';
import 'package:meter/widgets/text_widget.dart';

import '../../../../widgets/custom_textfield.dart';
import '../../../../widgets/radio/group_raadio_widget.dart';


class DeliveringPurposePricing extends StatelessWidget {
  const DeliveringPurposePricing({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DeliveringServiceController>();
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
            height: Get.height * 0.08,
            margin: const EdgeInsets.only(bottom: 10, left: 14, right: 14),
            child: CustomButton(
                title: "Choose",
                onTap: () {
                  //Change later
                  Get.back();
                  Get.back();
                  Get.back();
                  Get.back();
                })),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    const Flexible(
                        child: TextWidget(
                      textAlign: TextAlign.start,
                      title: "What is your purpose for pricing?",
                      textColor: AppColor.semiDarkGrey,
                      fontSize: 22,
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Image.asset(
                          AppImage.cancel,
                          width: 33,
                        )),
                  ],
                ),
                CustomTextField(
                    hintText: "Search",
                    title: "",
                    prefixImagePath: AppImage.search,
                    fillColor: AppColor.greyColor,
                    controller: TextEditingController()),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                ListView.separated(
                  itemCount: controller.purposeOfPricingList.length,
                  shrinkWrap: true,
                  itemBuilder: (itemBuilder, index) {
                    return Obx(() => filledContainerWithRadio(
                            controller.purposeOfPricingList[index],
                            controller.selectedPurpose.value,
                            controller.purposeOfPricingList[index], (newValue) {
                          controller.selectPurposeOfPricing(newValue!);
                        },
                            controller.selectedPurpose ==
                                controller.purposeOfPricingList[index]));
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: Get.height * 0.01,
                    );
                  },
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
