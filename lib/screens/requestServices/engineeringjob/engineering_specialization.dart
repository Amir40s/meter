import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/res/app_color/app_color.dart';
import '../../../constant/res/app_images/app_images.dart';
import '../../../controller/services/engineering_request_service_controller.dart';
import '../../../widgets/custom_button.dart';

import '../../../widgets/radio/group_raadio_widget.dart';
import '../../../widgets/text_widget.dart';

class EngineeringSpecialization extends StatelessWidget {
  const EngineeringSpecialization({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EngineeringRequestServiceController>();
    return Container(
      height: Get.height * 0.85,
      decoration: const BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          )),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Expanded(
                flex: 9,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Flexible(
                              child: TextWidget(
                            textAlign: TextAlign.start,
                            title: "What is your Specialization?",
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
                                  controller.purposeOfPricingList[index],
                                  (newValue) {
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
                )),
            Expanded(
              flex: 1,
              child: CustomButton(
                  title: "Choose",
                  onTap: () {
                    Get.back();
                    // Get.bottomSheet(
                    //   CustomSuccessScreen(
                    //     title: "Post Job",
                    //     buttonTitle: "Done",
                    //     desc:
                    //         "Your job has been posted. Click to show providers proposals",
                    //     onDoneTap: () {
                    //       Get.offAll(const BottomNavMain());
                    //     },
                    //   ),
                    // );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
