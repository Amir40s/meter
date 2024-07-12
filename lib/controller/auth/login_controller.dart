// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/get_rx.dart';
// import 'package:meter_app/services/api_services.dart';
// import 'package:meter_app/utils/backend_util/auth_util.dart';
// import 'package:meter_app/utils/backend_util/error_util.dart';
// import 'package:meter_app/utils/short_message_utils.dart';
// import 'package:meter_app/view/auth/Login/verification_screen.dart';
// import 'package:meter_app/view/bottom_nav/bottom_nav_main.dart';
//
// import '../../widget/success.dart';
//
// class LoginController extends GetxController {
//   var isChecked = false.obs;
//
//   void toggleCheckbox(bool? value) {
//     isChecked.value = value ?? false;
//   }
//
//   RxString flagUri = "flags/sa.png".obs;
//   RxString countryCode = "+966".obs;
//   RxString countryShortCode = "SA".obs;
//
//   void onChangeFlag(String changedUri, String code, String country) {
//     flagUri.value = changedUri; // Update the flag image URI.
//     countryCode.value = code; // Update the country code.
//     countryShortCode.value = country; // Update the country's short code.
//     print("$code $country");
//   }
//
//   final TextEditingController phoneNumberController = TextEditingController();
//   final TextEditingController otpController = TextEditingController();
//
//   String fullPhoneNumber() {
//     return "${countryCode.value}${phoneNumberController.text}";
//   }
//
//   RxString verificationId =
//       ''.obs; // Stores the verification ID received from Firebase Auth.
//   RxInt? resendToken = RxInt(0);
//   RxBool showResend = true.obs;
//
//   bool validatePhoneNumber() {
//     return AuthUtil.validatePhoneNumber(fullPhoneNumber(), countryCode.value);
//   }
//
//   RxBool sendCodeLoading = false.obs;
//
//   RxInt codeId = 0.obs;
//   RxBool showResendValue = true.obs;
//   RxString message = "".obs;
//   Future<void> startResendTimer() async {
//     showResendValue.value = false; // Hide resend button
//     await sendOtp();
//     Timer(const Duration(seconds: 60), () {
//       showResendValue.value = true; // Show resend button after 60 seconds
//     });
//   }
//
//   Future sendOtp() async {
//     try {
//       if (validatePhoneNumber()) {
//         bool isAlready = await AuthUtil.checkPhoneNumberExist(
//             phoneNumber: fullPhoneNumber());
//         if (isAlready) {
//           final sendCodeResponse = await ApiServices.sendOtp(fullPhoneNumber());
//           final jsonResponse = jsonDecode(sendCodeResponse.body);
//           if (sendCodeResponse.statusCode == 200) {
//             if (jsonResponse['code'] == 1) {
//               codeId.value = jsonResponse["id"];
//               message.value = jsonResponse["message"];
//               Get.to(const VerificationScreen());
//               ShortMessageUtils.showSuccess(jsonResponse["message"]);
//             } else {
//               ShortMessageUtils.showError(jsonResponse["message"]);
//               message.value = jsonResponse["message"];
//             }
//           } else {
//             ShortMessageUtils.showError(jsonResponse['message']);
//             message.value = jsonResponse["message"];
//           }
//         } else {
//           ShortMessageUtils.showError("Phone number does not exist");
//         }
//       } else {
//         ShortMessageUtils.showError("Please enter valid phone number");
//       }
//     } finally {}
//   }
//
//   RxString verifyMessage = "".obs;
//
//   Future verifyOtp() async {
//     try {
//       verifyOtpLoading.value = true;
//       final verifyResponse =
//           await ApiServices.verifyCode(otpController.text, codeId.value);
//       final jsonResponse = jsonDecode(verifyResponse.body);
//       if (verifyResponse.statusCode == 200) {
//         if (jsonResponse["code"] == 1) {
//           verifyMessage.value = jsonResponse["message"];
//           print("Full Phone Number is ${fullPhoneNumber()}");
//           await AuthUtil.checkPhoneNumberAndGetUserId(
//               phoneNumber: fullPhoneNumber());
//           // Get.back();
//           Get.bottomSheet(
//             CustomSuccessScreen(
//               title: "You have been logged in".tr,
//               onDoneTap: () {
//                 Get.offAll(const BottomNavMain());
//               },
//               desc:
//                   "Congratulations! Your phone number has been verified. Click continue to start"
//                       .tr,
//               buttonTitle: "Start".tr,
//             ),
//           );
//           // ShortMessageUtils.showSuccess(jsonResponse["message"]);
//         } else {
//           verifyMessage.value = jsonResponse["message"];
//           await AuthUtil.checkPhoneNumberAndGetUserId(
//               phoneNumber: fullPhoneNumber());
//           // Get.bottomSheet(
//           //   CustomSuccessScreen(
//           //     title: "You have been logged in".tr,
//           //     onDoneTap: () {
//           //       Get.offAll(const BottomNavMain());
//           //     },
//           //     desc:
//           //         "Congratulations! Your phone number has been verified. Click continue to start"
//           //             .tr,
//           //     buttonTitle: "Start".tr,
//           //   ),
//           // );
//           ShortMessageUtils.showError(jsonResponse["message"]);
//         }
//       } else {
//         verifyMessage.value = jsonResponse["message"];
//         ShortMessageUtils.showError(jsonResponse["message"]);
//       }
//     } finally {
//       verifyOtpLoading.value = false;
//       otpController.clear();
//     }
//   }
//
//   Future<void> onSendCode(BuildContext context) async {
//     try {
//       sendCodeLoading.value = true;
//       if (validatePhoneNumber()) {
//         bool isPhonePresent = await AuthUtil.checkPhoneNumberExist(
//             phoneNumber: fullPhoneNumber());
//
//         if (isPhonePresent) {
//           await sendOtp();
//         } else {
//           ShortMessageUtils.showError("Entered phone number is not present");
//           sendCodeLoading.value = false;
//         }
//       } else {
//         ShortMessageUtils.showError("Please enter valid phone number");
//         sendCodeLoading.value = false;
//       }
//     } finally {
//       sendCodeLoading.value = false;
//     }
//   }
//
//   // void startResendTimer(BuildContext context) {
//   //   showResend.value = false; // Hide resend button
//   //   log("Click");
//   //   authenticatePhoneNumber(context);
//   //   Timer(const Duration(seconds: 60), () {
//   //     showResend.value = true; // Show resend button after 60 seconds
//   //   });
//   // }
//
//   RxBool verifyOtpLoading = false.obs;
//
//   // Future<void> authenticatePhoneNumber(BuildContext context) async {
//   //   FirebaseAuth _auth = FirebaseAuth.instance;
//   //   try {
//   //     await _auth.verifyPhoneNumber(
//   //       // phoneNumber: "+923056022699",
//   //       phoneNumber: fullPhoneNumber(),
//   //       // Constructs the full phone number.
//   //       verificationCompleted: (PhoneAuthCredential credential) async {
//   //         // Auto-sign-in completion callback.
//   //         await _auth.signInWithCredential(credential);
//   //         print("Phone Number is ${fullPhoneNumber()}");
//   //         print("Authentication successful.");
//   //       },
//   //       verificationFailed: (FirebaseAuthException e) {
//   //         log("Error is $e");
//   //         // Verification failure callback.
//   //         ErrorUtil.handleOtpFailure(e);
//   //       },
//   //       codeSent: (String verificationIdReceived, int? resendTokenReceived) {
//   //         verificationId.value = verificationIdReceived;
//   //         if (resendTokenReceived != null) {
//   //           resendToken!.value = resendTokenReceived;
//   //         }
//   //         // showResend.value = false;
//   //         // startResendTimer(context);
//   //         Get.to(
//   //             const VerificationScreen()); // Navigates to OTP screen for user input.
//   //         sendCodeLoading.value = false;
//   //       },
//   //       codeAutoRetrievalTimeout: (String verificationIdReceived) {
//   //         // Auto-retrieval timeout callback.
//   //         verificationId.value = verificationIdReceived;
//   //       },
//   //       timeout: const Duration(seconds: 60),
//   //       forceResendingToken: resendToken?.value,
//   //     );
//   //   } catch (e) {
//   //     print('An unexpected error occurred: $e');
//   //   }
//   // }
//   //
//   // Future<void> verifyOtp() async {
//   //   FirebaseAuth _auth = FirebaseAuth.instance;
//   //   try {
//   //     verifyOtpLoading.value = true;
//   //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
//   //       verificationId: verificationId.value,
//   //       smsCode: otpController.text, // OTP entered by the user.
//   //     );
//   //     UserCredential userCredential =
//   //         await _auth.signInWithCredential(credential);
//   //
//   //     User? user = userCredential.user;
//   //
//   //     if (user != null) {
//   //       Get.bottomSheet(
//   //         CustomSuccessScreen(
//   //           title: "You have been logged in".tr,
//   //           onDoneTap: () {
//   //             Get.offAll(const BottomNavMain());
//   //           },
//   //           desc:
//   //               "Congratulations! Your phone number has been verified. Click continue to start"
//   //                   .tr,
//   //           buttonTitle: "Start".tr,
//   //         ),
//   //       );
//   //       // Get.offAll(SellerFaceAuth());
//   //       ///Navigation here
//   //     } else {
//   //       log("User is null.");
//   //     }
//   //   } catch (e) {
//   //     print("Error is $e");
//   //     ErrorUtil.handleOtpErrors(e); // Handles OTP verification errors.
//   //   } finally {
//   //     verifyOtpLoading.value = false;
//   //   }
//   // }
// }
