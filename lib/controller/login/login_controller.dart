import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/bottomSheet/success/success_bottom_sheet.dart';
import 'package:meter/constant.dart';
import 'package:meter/constant/phoneUtils/phone_utils.dart';
import 'package:meter/constant/routes/routes_name.dart';
import 'package:meter/controller/home/home_controller.dart';
import 'package:meter/http/api/otp_api_services.dart';

import '../../constant/prefUtils/message_utills.dart';
import '../account/profile_controller.dart';
import '../bottomNav/bottom_nav_controller_main.dart';

class LoginController extends GetxController {

  final  phoneNumberController = TextEditingController();
  final  otpController = TextEditingController();

  var isChecked = false.obs;
  RxString verificationId =
      ''.obs; // Stores the verification ID received from Firebase Auth.
  RxInt? resendToken = RxInt(0);
  RxBool showResend = true.obs;
  RxString flagUri = "flags/sa.png".obs;
  RxString countryCode = "+966".obs;
  RxString countryShortCode = "SA".obs;
  RxBool verifyOtpLoading = false.obs;
  RxBool sendCodeLoading = false.obs;

  RxInt codeId = 0.obs;
  RxBool showResendValue = true.obs;
  RxString message = "".obs;
  RxString verifyMessage = "".obs;
  RxString userUID = "".obs;


  void toggleCheckbox(bool? value) {
    isChecked.value = value ?? false;
  }


  void onChangeFlag(String changedUri, String code, String country) {
    flagUri.value = changedUri; // Update the flag image URI.
    countryCode.value = code; // Update the country code.
    countryShortCode.value = country; // Update the country's short code.
    log("$code $country");
  }

  String fullPhoneNumber() {
    return "${countryCode.value}${phoneNumberController.text}";
  }

  bool validatePhoneNumber() {
    return PhoneUtil.validatePhoneNumber(fullPhoneNumber(), countryCode.value);
  }

  Future<void> startResendTimer() async {
    showResendValue.value = false; // Hide resend button
    await sendOtp();
    Timer(const Duration(seconds: 60), () {
      showResendValue.value = true; // Show resend button after 60 seconds
    });
  }

  Future sendOtp() async {
    try {
      if (validatePhoneNumber()) {
        bool isAlready = await PhoneUtil.checkPhoneNumberExist(
            phoneNumber: fullPhoneNumber());
        if (isAlready) {
          final sendCodeResponse = await OtpApiServices.sendOtp(fullPhoneNumber());
          final jsonResponse = jsonDecode(sendCodeResponse.body);
          if (sendCodeResponse.statusCode == 200) {
            if (jsonResponse['code'] == 1) {
              codeId.value = jsonResponse["id"];
              message.value = jsonResponse["message"];
              Get.toNamed(RoutesName.otpVerificationScreen);
              ShortMessageUtils.showSuccess(jsonResponse["message"]);
            } else {
              ShortMessageUtils.showError(jsonResponse["message"]);
              message.value = jsonResponse["message"];
            }
          } else {
            ShortMessageUtils.showError(jsonResponse['message']);
            message.value = jsonResponse["message"];
          }
        } else {
          ShortMessageUtils.showError("Phone number does not exist");
        }
      } else {
        ShortMessageUtils.showError("Please enter valid phone number");
      }
    } finally {}
  }


  Future<void> verifyOtp() async {
    try {
      verifyOtpLoading.value = true;
      final verifyResponse =
      await OtpApiServices.verifyCode(otpController.text, codeId.value);
      final jsonResponse = jsonDecode(verifyResponse.body);
      if (verifyResponse.statusCode == 200) {
        if (jsonResponse["code"] == 1) {
          verifyMessage.value = jsonResponse["message"];
          print("Full Phone Number is ${fullPhoneNumber()}");
          await PhoneUtil.checkPhoneNumberAndGetUserId(
              phoneNumber: fullPhoneNumber());
          Get.bottomSheet(
            SuccessBottomSheet(
              title: "You have been logged in".tr,
              onDoneTap: () async{
                if(userUID.isNotEmpty) {
                  setUserUID(userUID.toString());
                  Get.put(ProfileController(), permanent: true);
                  final controller = Get.find<ProfileController>();
                  await controller.fetchUserData(userUID.toString());
                  final bottomNavController =  Get.find<BottomNavController>();
                  final homeController =  Get.find<HomeController>();
                  log("message::${bottomNavController.currentRole.value.toString()}");
                  await bottomNavController.getCurrentRole();
                  await homeController.getCurrentRole();
                  Get.offAllNamed(RoutesName.bottomNavMain);
                }

              },
              desc:
              "Congratulations! Your phone number has been verified. Click continue to start"
                  .tr,
              buttonTitle: "Start".tr,
            ),
          );

        } else {
          verifyMessage.value = jsonResponse["message"];
          await PhoneUtil.checkPhoneNumberAndGetUserId(
              phoneNumber: fullPhoneNumber());
          ShortMessageUtils.showError(jsonResponse["message"]);
        }
      } else {
        verifyMessage.value = jsonResponse["message"];
        ShortMessageUtils.showError(jsonResponse["message"]);
      }
    } finally {
      verifyOtpLoading.value = false;
      otpController.clear();
    }
  }

  Future<void> onSendCode(BuildContext context) async {
    try {
      sendCodeLoading.value = true;
      if (validatePhoneNumber()) {
      //  bool isPhonePresent = await PhoneUtil.checkPhoneNumberExist(phoneNumber: fullPhoneNumber());

        final result = await PhoneUtil.checkPhoneNumberExists(phoneNumber: fullPhoneNumber());

        if (result['exists'] == true) {
          userUID.value = result['uid'].toString();
          log("message::$userUID");
          // if(userUID.isNotEmpty){
          //   setUserUID(userUID.toString());
          //   Get.put(ProfileController(), permanent: true);
          //   final controller = Get.find<ProfileController>();
          //   await controller.fetchUserData(userUID.toString());
          //   final bottomNavController =  Get.find<BottomNavController>();
          //   final homeController =  Get.find<HomeController>();
          //   log("message::${bottomNavController.currentRole.value.toString()}");
          //   await bottomNavController.getCurrentRole();
          //   await homeController.getCurrentRole();
          //   Get.offAllNamed(RoutesName.bottomNavMain);
          // }
       await sendOtp();
        } else {
          ShortMessageUtils.showError("Entered phone number is not present");
          sendCodeLoading.value = false;
        }
      } else {
        ShortMessageUtils.showError("Please enter valid phone number");
        sendCodeLoading.value = false;
      }
    } finally {
      sendCodeLoading.value = false;
    }
  }
}
