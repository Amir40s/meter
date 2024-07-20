import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/bottomSheet/success/success_bottom_sheet.dart';
import 'package:meter/model/requestServices/send_request_model.dart';
import 'package:meter/provider/db_provider.dart';
import 'package:meter/screens/bottomNav/bottom_nav_screen.dart';
import 'package:meter/widgets/check_box_widget.dart';
import 'package:meter/widgets/image_pick_widget.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../constant/errorUtills/image_utils.dart';
import '../../constant/res/app_color/app_color.dart';
import '../../controller/account/profile_controller.dart';
import '../../controller/auth/provider_auth_controller.dart';
import '../../controller/bottomNav/bottom_nav_controller_main.dart';
import '../../controller/requestForm/request_form_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_linear_progress.dart';
import '../../widgets/custom_loading.dart';

class UploadDeviceBottomSheet extends StatelessWidget {
  String title, price,tax,fees,total, details,requestID,customerID;
   UploadDeviceBottomSheet({super.key,
  this.title = "",
  this.price = "",
  this.tax = "",
  this.fees = "",
  this.total = "",
  this.details = "",
  this.requestID = "",
  this.customerID = "",
  });

  @override
  Widget build(BuildContext context) {
    final imageController = Get.put(ProviderAuthController());
    final controller = Get.put(RequestFormController());
    final profileController = Get.find<ProfileController>();
    return Container(
      height: Get.height * 0.5,
      decoration: BoxDecoration(
          color: AppColor.whiteColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.02,
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
                Obx(
                      () => Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10),
                    child: ImagePickWidget(
                        onTap: () {
                          ImageUtil.pickAndUpdateFile(
                              imageController.fileName, imageController.filePath);
                        },
                        fileName: imageController.fileName.value,
                        isFile: imageController.filePath.value != "",
                        title: "Click to upload \n your papers"),
                  ),
                ),
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
                Obx(() => imageController.isLoading.value
                    ? Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.only(
                        left: Get.width / 2.3, right: Get.width / 2.3),
                    height: Get.height * 0.04,
                    child: const CustomLoading())
                    : MyCustomButton(
                        title: "Apply".tr,
                        onTap: () async{
                          final fileUrl = await ImageUtil.uploadToDatabase(imageController.filePath.value);
                          SendRequestModel model = SendRequestModel(
                              id: getAutoUid().toString(),
                              requestID: requestID,
                              userUID: getCurrentUid().toString(),
                              customerID: customerID,
                              title: title,
                              price: price,
                              tax: tax,
                              fees: fees,
                              total: total,
                              details: details,
                              profileImage: profileController.user.value.profilePicture.toString(),
                              documentUrl: fileUrl);
                          await Provider.of<DbProvider>(context,listen: false).sendRequestDB(model);
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
                        })),
                // CustomButton(
                //     title: "Apply",
                //     onTap: () async{
                //
                //       // Get.dialog(
                //       //     SuccessBottomSheet(
                //       //         onDoneTap: () {
                //       //           Get.offAll(const BottomNav());
                //       //         },
                //       //         title: "Applied Proposal",
                //       //         buttonTitle: "Done",
                //       //         desc:
                //       //         "Your proposal has been applied. wait approvment from customer,"),
                //       //     barrierDismissible: false);
                //     })
              ],
            ),
          )
        ],
      ),
    );
  }
}