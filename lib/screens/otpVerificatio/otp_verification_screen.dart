import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant/phoneUtils/phone_utils.dart';

import '../../controller/login/login_controller.dart';
import '../../widgets/verification_widget.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    log("Controller ${controller.fullPhoneNumber()}");
    return Obx(() => VerificationWidget(
      controller: controller.otpController,
      buttonTitle: "Verify Code",
      showResend: controller.showResendValue.value,
      showLoading: controller.verifyOtpLoading.value,
      onTap: () {
        controller.verifyOtp();
      },
      onResendTap: () {
        controller.startResendTimer();
      },
      countryCode: PhoneUtil.formatPhoneNumber(
          controller.fullPhoneNumber()),
      phoneNumber: controller.phoneNumberController.text,
    ));
  }
}
