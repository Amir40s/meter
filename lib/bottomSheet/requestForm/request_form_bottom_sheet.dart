import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/bottomSheet/requestForm/upload_device_bottom_sheet.dart';
import 'package:meter/constant.dart';
import 'package:meter/model/requestServices/request_services_model.dart';
import 'package:meter/provider/chat/chat_provider.dart';
import 'package:provider/provider.dart';

import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../controller/requestForm/request_form_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_linear_progress.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/radio/group_raadio_widget.dart';
import '../../widgets/text_widget.dart';


class RequestFormBottomSheet extends StatelessWidget {
  final bool showPicture;
  RequestServicesModel? model;
  String chatRoomID,otherEmail;
  RequestFormBottomSheet({
    super.key,
  this.showPicture = true,
  this.model,
  this.chatRoomID = '',
  this.otherEmail = '',
  });

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RequestFormController());
    controller.taxController.text = "15";
    final chatProvider = Provider.of<ChatProvider>(context,listen: false);
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Container(
          height: Get.height * 0.87,
          decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  CustomLinearProgress(
                    value: showPicture ? 0.3 : 1,
                    backgroundColor: AppColor.primaryColorShade1,
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  if (showPicture) ...[
                    CustomTextField(
                        hintText: "Enter title",
                        title: "Title",
                        validator: (value) =>"title required",
                        controller: controller.titleController)
                  ],
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: controller.priceController,
                          hintText: "Enter Price",
                          title: "Price",
                          validator: (value) =>"price required",
                          textInputType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                      Expanded(
                        child: CustomTextField(
                          controller: controller.taxController,
                          prefixImagePath: AppImage.percent,
                          hintText: "Enter Tax",
                          title: "Tax",
                          validator: (value) =>"tax required",
                          textInputType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  const TextWidget(
                      title: "Fees",
                      textColor: AppColor.semiDarkGrey,
                      fontSize: 16),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Row(
                    children: [
                      Obx(() => rowWithRadio(
                        'Consolation',
                        controller.selectedOption.value,
                        'Consolation',
                            (newValue) => controller.selectOption(newValue!),
                      )),
                      Obx(() => rowWithRadio(
                        'Request Pricing',
                        controller.selectedOption.value,
                        'Request Pricing',
                            (newValue) => controller.selectOption(newValue!),
                      )),
                    ],
                  ),
                  CustomTextField(
                    controller: controller.totalController,
                    textInputType: TextInputType.number,
                    hintText: "100.50",
                    title: "Total",
                    validator: (value) => "total required",
                    hintTextColor: AppColor.primaryColor,
                  ),
                  CustomTextField(
                    controller: controller.detailsController,
                    hintText: "Write Details",
                    title: "Details",
                    maxLine: 5,
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  // if (showPicture)
                  //   Obx(
                  //     () => checkBoxWithTitle(
                  //       controller.isAgreeTermsChecked.value,
                  //       RichText(
                  //         text: TextSpan(
                  //           style: AppTextStyle.dark14,
                  //           children: [
                  //             TextSpan(text: 'I agree to the '.tr),
                  //             TextSpan(
                  //               text: 'terms & conditions'.tr,
                  //               style: AppTextStyle.dark14
                  //                   .copyWith(color: AppColor.primaryColor),
                  //               recognizer: TapGestureRecognizer()
                  //                 ..onTap = () {
                  //                   // Navigate to terms & conditions page or handle click event
                  //                   print('Navigate to terms & conditions');
                  //                 },
                  //             ),
                  //             TextSpan(text: ' by creating account.'.tr),
                  //           ],
                  //         ),
                  //       ),
                  //       (newValue) => controller.toggleAgreeTerms(newValue),
                  //     ),
                  //   ),
                  // SizedBox(
                  //   height: Get.height * 0.03,
                  // ),
                  CustomButton(
                      title: showPicture ? "Continue" : "Send",
                      onTap: () {
                        if (showPicture) {
                          Get.back();
                          Get.bottomSheet(UploadDeviceBottomSheet(
                            title: controller.titleController.text.toString(),
                            price: controller.priceController.text.toString(),
                            tax: controller.taxController.text.toString(),
                            fees: controller.selectedOption.value.toString(),
                            total: controller.totalController.text.toString(),
                            details: controller.detailsController.text.toString(),
                            customerID: model!.userUID.toString(),
                            requestID: model!.id.toString(),
                          ),
                              isScrollControlled: true);
                          // if(_formKey.currentState!.validate()){
                          //
                          //   _formKey.currentState!.save();
                          //
                          // }

                        } else {
                          Get.back();
                          chatProvider.sendOfferMessage(
                              price: controller.priceController.text.toString(),
                              tax: controller.taxController.text.toString(),
                              fees: controller.selectedOption.toString(),
                              total: controller.totalController.text.toString(),
                              details: controller.detailsController.text.toString(),
                              chatRoomId: chatRoomID,
                              otherEmail: otherEmail
                          );

                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


