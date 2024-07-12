import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant/res/app_color/app_color.dart';
import 'package:meter/constant/routes/routes_name.dart';
import 'package:meter/controller/auth/face_recognize_controller.dart';
import 'package:meter/widgets/custom_button.dart';
import 'package:meter/widgets/custom_header.dart';
import 'package:meter/widgets/custom_loading.dart';

import '../../widgets/text_widget.dart';

class FaceAuth extends StatelessWidget {
  const FaceAuth({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FaceRecognizeController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const CustomHeader(title: "Face Id Security"),
              const TextWidget(
                  title: "Secure your account with your face",
                  textColor: AppColor.semiDarkGrey,
                  fontSize: 14),
              const TextWidget(
                  title: "using Face ID",
                  textColor: AppColor.semiDarkGrey,
                  fontSize: 14),
              SizedBox(
                height: Get.height * 0.02,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(14.0),
              //   child: Image.asset(
              //     // AppImage.initialFace,
              //     AppImage.authenticatedFace,
              //     // AppImage.processingFace,
              //   ),
              // ),
              SizedBox(
                height: Get.height * 0.04,
              ),

              Obx(() {
                if (!controller.isInitialized.value) {
                  return const CustomLoading();
                }
                if (controller.imagePath.value == "") {
                  return SizedBox(
                    width: Get.width * 0.70,
                    height: Get.height * 0.35,
                    child: CameraPreview(controller.cameraController),
                  );
                } else {
                  return SizedBox(
                    width: Get.width * 0.70,
                    height: Get.height * 0.35,
                    child: Image.file(File(controller.imagePath.value)),
                  );
                }
              }),

              SizedBox(
                height: Get.height * 0.02,
              ),
              Obx(() {
                if (controller.imagePath.value == "") {
                  // Show capture button when no image is present
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomButton(
                      title: "Capture",
                      onTap: () {
                        controller.captureImage();
                      },
                    ),
                  );
                } else if (controller.imagePath.value != "" &&
                    !controller.isFaceRecognized.value) {
                  // Show loading indicator when an image is being processed
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CustomLoading(),
                  );
                } else if (controller.isFaceRecognized.value) {
                  // Show an empty container when face is recognized
                  return Container();
                }
                return Container();
              }),

              SizedBox(
                height: Get.height * 0.02,
              ),
              const TextWidget(
                  title: "Please position your face in front of",
                  textColor: AppColor.semiDarkGrey,
                  fontSize: 14),
              const TextWidget(
                  title: "the camera to authenticate with Face ID",
                  textColor: AppColor.semiDarkGrey,
                  fontSize: 14),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset(AppImage.check),
                    const SizedBox(
                      width: 10,
                    ),
                    Obx(() => controller.isFaceRecognized.value
                        ? const TextWidget(
                            title: "Authentication successful",
                            textColor: AppColor.successColor,
                            fontSize: 14)
                        : Container())
                  ],
                ),
              ),

              Obx(() => Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: controller.isLoading.value
                        ? const CustomLoading()
                        : Row(
                            children: [
                              Expanded(
                                  child: MyCustomButton(
                                onTap: () {
                                  // controller.imagePath.value = "";
                                  Get.toNamed(RoutesName.fingerAuth);
                                },
                                title: "Skip",
                                backgroundColor: AppColor.lightBlueShade,
                                textColor: AppColor.primaryColor,
                              )),
                              const SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                  child: MyCustomButton(
                                onTap: () {
                                  controller.onContinueClick();
                                },
                                title: "Continue".tr,
                              )),
                            ],
                          ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
