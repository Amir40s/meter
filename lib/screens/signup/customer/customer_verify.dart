// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:meter_app/controller/auth_controller/customer_auth_controller.dart';
// import 'package:meter_app/utils/useful_function_util.dart';
// import 'package:meter_app/widget/verification_widget.dart';
//
// class CustomerVerify extends StatelessWidget {
//   const CustomerVerify({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<CustomerAuthController>();
//     return Obx(() => VerificationWidget(
//           controller: controller.otpController,
//           buttonTitle: "Verify Code",
//           showResend: true,
//           showLoading: controller.verifyOtpLoading.value,
//           onTap: () {
//             controller.verifyOtp();
//           },
//           onResendTap: () {
//             controller.startResendTimer(context);
//           },
//           countryCode: UsefulFunctionUtil.formatPhoneNumber(
//               controller.fullPhoneNumber()),
//           phoneNumber: controller.phoneNumberController.text,
//         ));
//   }
// }
