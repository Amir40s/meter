import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../controller/services/request_service_controler.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/radio/group_raadio_widget.dart';
import '../../widgets/text_widget.dart';

class PurposePricingBottomSheet extends StatelessWidget {
  const PurposePricingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RequestServiceController>();
    return Container(
      height: Get.height * 0.87,
      decoration: const BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            topLeft: Radius.circular(12),
          )),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                      flex: 9,
                      child: TextWidget(
                        textAlign: TextAlign.start,
                        title: "What is your purpose for pricing?",
                        textColor: AppColor.semiDarkGrey,
                        fontSize: 22,
                      )),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Expanded(
                    flex: 2,
                    child: Transform.translate(
                      offset: Offset(0, -Get.height * 0.015),
                      child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Image.asset(
                            AppImage.cancel,
                            width: 40,
                            color: AppColor.semiDarkGrey,
                          )),
                    ),
                  ),
                ],
              ),
              // CustomTextField(
              //     hintText: "Search",
              //     title: "",
              //     onChanged: (newValue) {
              //       controller.onChangeSearch(newValue);
              //     },
              //     showSpace: true,
              //     prefixImagePath: AppImage.search,
              //     fillColor: AppColor.greyColor,
              //     controller: TextEditingController()),
              SizedBox(
                height: Get.height * 0.04,
              ),

              ListView.separated(
                itemCount: controller.purposeOfPricingList.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
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
                height: Get.height * 0.02,
              ),
              Container(
                  height: Get.height * 0.08,
                  margin:
                      const EdgeInsets.only(bottom: 10, left: 14, right: 14),
                  child: CustomButton(
                      title: "Choose",
                      onTap: () {
                        Get.back();
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
