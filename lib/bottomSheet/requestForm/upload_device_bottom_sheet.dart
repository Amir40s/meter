import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/bottomSheet/success/success_bottom_sheet.dart';
import 'package:meter/screens/bottomNav/bottom_nav_screen.dart';
import 'package:meter/widgets/check_box_widget.dart';
import 'package:meter/widgets/image_pick_widget.dart';

import '../../constant.dart';
import '../../constant/res/app_color/app_color.dart';
import '../../controller/bottomNav/bottom_nav_controller_main.dart';
import '../../controller/requestForm/request_form_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_linear_progress.dart';

class UploadDeviceBottomSheet extends StatelessWidget {
  const UploadDeviceBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RequestFormController());
    return Container(
      height: Get.height * 0.5,
      decoration: BoxDecoration(
          color: AppColor.whiteColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.04,
          ),
          const CustomLinearProgress(
            value: 1,
            backgroundColor: AppColor.primaryColorShade1,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14.0),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.04,
                ),
                const ImagePickWidget(title: "Click to upload"),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Obx(
                      () => CheckBoxWidget(
                   checkValue:  controller.isAgreeTermsChecked.value,
                  title:   RichText(
                      text: TextSpan(
                        style: AppTextStyle.dark14,
                        children: [
                          TextSpan(text: 'I agree to the '.tr),
                          TextSpan(
                            text: 'terms & conditions'.tr,
                            style: AppTextStyle.dark14
                                .copyWith(color: AppColor.primaryColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigate to terms & conditions page or handle click event
                                log('Navigate to terms & conditions');
                              },
                          ),
                          TextSpan(text: ' by creating account.'.tr),
                        ],
                      ),
                    ),
                       onChanged:  (newValue) => controller.toggleAgreeTerms(newValue),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                CustomButton(
                    title: "Apply",
                    onTap: () {
                      Get.back();
                      Get.bottomSheet(
                        SuccessBottomSheet(
                            onDoneTap: () {
                              Get.back();
                              Get.find<BottomNavController>()
                                  .currentIndex
                                  .value = 2;
                              // Get.offAll(const BottomNavMain());
                            },
                            title: "Applied Proposal",
                            buttonTitle: "Done",
                            desc:
                            "Your proposal has been applied. wait approvment from customer,"),
                      );
                      // Get.dialog(
                      //     SuccessBottomSheet(
                      //         onDoneTap: () {
                      //           Get.offAll(const BottomNav());
                      //         },
                      //         title: "Applied Proposal",
                      //         buttonTitle: "Done",
                      //         desc:
                      //         "Your proposal has been applied. wait approvment from customer,"),
                      //     barrierDismissible: false);
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}