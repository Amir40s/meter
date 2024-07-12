// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/get_rx.dart';
// import 'package:intl/intl.dart';
// import 'package:meter_app/model/auth/auth_model.dart';
// import 'package:meter_app/res/app_color/app_color.dart';
// import 'package:meter_app/services/api_services.dart';
// import 'package:meter_app/utils/backend_util/auth_util.dart';
// import 'package:meter_app/utils/backend_util/collection_utils.dart';
// import 'package:meter_app/utils/backend_util/constant_util.dart';
// import 'package:meter_app/utils/backend_util/dbutil.dart';
// import 'package:meter_app/utils/backend_util/error_util.dart';
// import 'package:meter_app/utils/backend_util/image_util.dart';
// import 'package:meter_app/utils/pref_util.dart';
// import 'package:meter_app/utils/short_message_utils.dart';
// import 'package:meter_app/utils/useful_function_util.dart';
// import 'package:meter_app/view/auth/Signup/seller_login/face_auth.dart';
//
// import '../../widget/backend/verification_bottom_sheet.dart';
//
// class ProviderAuthController extends GetxController {
//   final TextEditingController facilityNameController = TextEditingController();
//   final TextEditingController typeOfActivityController =
//       TextEditingController();
//   final TextEditingController licenseNumberController = TextEditingController();
//   final TextEditingController descriptionOfServiceController =
//       TextEditingController();
//   final TextEditingController registrationOfService = TextEditingController();
//   final TextEditingController ownerNameController = TextEditingController();
//   final TextEditingController commercialRegistrationController =
//       TextEditingController();
//   final TextEditingController dateOfCommercialRegistrationController =
//       TextEditingController();
//   final TextEditingController managerNameController = TextEditingController();
//   final TextEditingController regionController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController neighborhoodController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();
//
//   Rx<DateTime> dateOfCommercialRegistration = DateTime.now().obs;
//
//   RxString filePath = "".obs;
//   RxString fileName = "".obs;
//   RxString imagePath = "".obs;
//
//   Future<void> pickCommercialRegistrationDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2030),
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: AppColor.primaryColor, // header background color
//               // onPrimary: AppColor.semiTransparentDarkGrey, // header text color
//               onSurface: AppColor.semiDarkGrey, // body text color
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 foregroundColor: AppColor.primaryColor, // button text color
//               ),
//             ),
//           ),
//           child:
//               child ?? Container(), // Provide a default widget if child is null
//         );
//       },
//     );
//
//     if (pickedDate != null) {
//       dateOfCommercialRegistration.value =
//           pickedDate; // Update observable with the picked date
//       final String formattedDate =
//           DateFormat('yyyy/dd/MM').format(pickedDate); // Format date
//       dateOfCommercialRegistrationController.text =
//           formattedDate; // Display formatted date in the input field
//     }
//   }
//
//   RxBool sendOtpLoading = false.obs;
//   RxString message = "".obs;
//   RxInt codeId = 0.obs;
//   RxBool showResendValue = true.obs;
//   RxBool isBottomSheetAlreadyOpen = false.obs;
//
//   TextEditingController otpController = TextEditingController();
//
//   Future sendOtp() async {
//     try {
//       if (validatePhoneNumber()) {
//         bool isAlready = await AuthUtil.checkPhoneNumberExist(
//             phoneNumber: fullPhoneNumber());
//         if (!isAlready) {
//           sendOtpLoading.value = true;
//           final sendCodeResponse = await ApiServices.sendOtp(fullPhoneNumber());
//           final jsonResponse = jsonDecode(sendCodeResponse.body);
//           if (sendCodeResponse.statusCode == 200) {
//             if (jsonResponse['code'] == 1) {
//               message.value = jsonResponse["message"];
//               codeId.value = jsonResponse["id"];
//               ShortMessageUtils.showSuccess(jsonResponse["message"]);
//               if (!isBottomSheetAlreadyOpen.value) {
//                 Get.bottomSheet(
//                     isDismissible: false,
//                     enableDrag: false,
//                     Obx(
//                       () => VerificationBottomSheet(
//                         phoneNumber: UsefulFunctionUtil.formatPhoneNumber(
//                             fullPhoneNumber()),
//                         controller: otpController,
//                         isLoadingVerify: verifyOneTimePasswordLoading.value,
//                         showResend: showResendValue.value,
//                         onResendCodeTap: () {
//                           showResendValue.value = false; // Hide resend button
//                           isBottomSheetAlreadyOpen.value = true;
//                           sendOtp();
//                           Timer(const Duration(seconds: 60), () {
//                             showResendValue.value =
//                                 true; // Show resend button after 60 seconds
//                           });
//                         },
//                         onVerifyTap: () {
//                           verifyOtp();
//                         },
//                       ),
//                     ));
//               }
//             } else {
//               ShortMessageUtils.showError(jsonResponse["message"]);
//               message.value = jsonResponse["message"];
//             }
//           } else {
//             sendOtpLoading.value = false;
//             ShortMessageUtils.showError(jsonResponse['message']);
//             message.value = jsonResponse["message"];
//           }
//         } else {
//           ShortMessageUtils.showError("Phone number already exist");
//         }
//       } else {
//         ShortMessageUtils.showError("Please enter valid phone number");
//       }
//     } finally {
//       sendOtpLoading.value = false;
//       isBottomSheetAlreadyOpen.value = false;
//     }
//   }
//
//   RxBool verifyOneTimePasswordLoading = false.obs;
//   RxString verifyMessage = "".obs;
//
//   Future verifyOtp() async {
//     try {
//       verifyOneTimePasswordLoading.value = true;
//       final verifyResponse =
//           await ApiServices.verifyCode(otpController.text, codeId.value);
//       final jsonResponse = jsonDecode(verifyResponse.body);
//       if (verifyResponse.statusCode == 200) {
//         if (jsonResponse["code"] == 1) {
//           verifyMessage.value = jsonResponse["message"];
//           Get.back();
//           ShortMessageUtils.showSuccess(jsonResponse["message"]);
//         } else {
//           verifyMessage.value = jsonResponse["message"];
//           ShortMessageUtils.showError(jsonResponse["message"]);
//         }
//       } else {
//         verifyMessage.value = jsonResponse["message"];
//         ShortMessageUtils.showError(jsonResponse["message"]);
//       }
//     } finally {
//       verifyOneTimePasswordLoading.value = false;
//       otpController.clear();
//     }
//   }
//
//   void clearAllFields() {
//     facilityNameController.clear();
//     typeOfActivityController.clear();
//     licenseNumberController.clear();
//     ownerNameController.clear();
//     commercialRegistrationController.clear();
//     dateOfCommercialRegistrationController.clear();
//     managerNameController.clear();
//     regionController.clear();
//     cityController.clear();
//     neighborhoodController.clear();
//     locationController.clear();
//     passwordController.clear();
//     confirmPasswordController.clear();
//   }
//
//   var selectedProviderServiceOption =
//       'Company'.obs; // Observable to track the selected option
//
//   void selectProviderServiceOption(String option) {
//     selectedProviderServiceOption.value = option;
//   }
//
//   RxBool passwordHide = true.obs;
//   void togglePassword() {
//     passwordHide.value = !passwordHide.value;
//   }
//
//   RxBool confirmPasswordHide = true.obs;
//   void toggleConfirmPassword() {
//     confirmPasswordHide.value = !confirmPasswordHide.value;
//   }
//
//   var isAgreeTermsChecked = false.obs;
//
//   void toggleAgreeTerms(bool? value) {
//     isAgreeTermsChecked.value = value ?? false;
//   }
//
//   RxString phoneNumberFlagUri = "flags/sa.png".obs;
//   RxString phoneNumberCountryCode = "+966".obs;
//   RxString phoneNumberCountryShortCode = "SA".obs;
//
//   void onChangePhoneNumberFlag(String changedUri, String code, String country) {
//     phoneNumberFlagUri.value = changedUri; // Update the flag image URI.
//     phoneNumberCountryCode.value = code; // Update the country code.
//     phoneNumberCountryShortCode.value =
//         country; // Update the country's short code.
//     print("$code $country $changedUri");
//   }
//
//   RxString managerPhoneNumberFlagUri = "flags/sa.png".obs;
//   RxString managerPhoneNumberCountryCode = "+966".obs;
//   RxString managerPhoneNumberCountryShortCode = "SA".obs;
//
//   void onChangeFlag(String changedUri, String code, String country) {
//     managerPhoneNumberFlagUri.value = changedUri; // Update the flag image URI.
//     managerPhoneNumberCountryCode.value = code; // Update the country code.
//     managerPhoneNumberCountryShortCode.value =
//         country; // Update the country's short code.
//     print("$code $country");
//   }
//
//   final TextEditingController phoneNumberController = TextEditingController();
//   final TextEditingController managerPhoneNumberController =
//       TextEditingController();
//
//   void onChangeActivity(String newValue) {
//     typeOfActivityController.text = newValue;
//   }
//
//   String fullPhoneNumber() {
//     return "${phoneNumberCountryCode.value}${phoneNumberController.text}";
//   }
//
//   String fullManagerPhoneNumber() {
//     return "${managerPhoneNumberCountryCode.value}${managerPhoneNumberController.text}";
//   }
//
//   bool validatePhoneNumber() {
//     return AuthUtil.validatePhoneNumber(
//         fullPhoneNumber(), phoneNumberCountryCode.value);
//   }
//
//   bool validateManagerPhoneNumber() {
//     return AuthUtil.validatePhoneNumber(
//         fullManagerPhoneNumber(), managerPhoneNumberCountryCode.value);
//   }
//
//   bool get areBothPasswordEqual =>
//       passwordController.text == confirmPasswordController.text;
//
//   RxBool isLoading = false.obs;
//
//   Future<void> completeProviderRegistration(
//       GlobalKey<FormState> _formKey) async {
//     try {
//       if (_formKey.currentState!.validate() &&
//           areBothPasswordEqual &&
//           imagePath.isNotEmpty &&
//           isAgreeTermsChecked.value) {
//         isLoading.value = true;
//         String userId = DbUtil.getAutoUid()!;
//         log("UserId is $userId");
//         log("FilePath $filePath");
//         String fileUrl = await ImageUtil.uploadToDatabase(filePath.value);
//         String imageUrl = await ImageUtil.uploadToDatabase(imagePath.value);
//         AuthModel authModel = AuthModel(
//           userId: userId,
//           role: ConstantUtil.provider,
//           serviceProvider: selectedProviderServiceOption.value,
//           facilityName: facilityNameController.text,
//           licenseNumber: licenseNumberController.text,
//           typeOfActivity: typeOfActivityController.text,
//           iosCommercialRegistrationDate:
//               dateOfCommercialRegistration.value.toIso8601String(),
//           commercialRegistration: commercialRegistrationController.text,
//           ownerName: ownerNameController.text,
//           phoneNumber: fullPhoneNumber(),
//           managerName: managerNameController.text,
//           managerPhoneNumber: fullManagerPhoneNumber(),
//           descriptionOfServices: descriptionOfServiceController.text,
//           profilePicture: imageUrl,
//           isFaceVerify: false,
//           isFingerVerify: false,
//           region: regionController.text,
//           city: cityController.text,
//           neighborhood: neighborhoodController.text,
//           location: locationController.text,
//           long: "58.90",
//           lat: "24.89",
//           password: passwordController.text,
//           fileUrl: fileUrl,
//           email: "",
//         );
//         log("UserId is $userId");
//         await CollectionUtils.userCollection
//             .doc(userId)
//             .set(authModel.toJson());
//         PrefUtil.setString(PrefUtil.userId, userId);
//         Get.offAll(const SellerFaceAuth());
//
//         // You need to save authModel to your database here
//       } else {
//         if (!_formKey.currentState!.validate()) {
//           ShortMessageUtils.showError(
//               "Please fill in all required fields correctly.");
//         }
//         if (!areBothPasswordEqual) {
//           ShortMessageUtils.showError("Both passwords must be the same.");
//         }
//         if (imagePath.isEmpty) {
//           ShortMessageUtils.showError("Please upload an image.");
//         }
//         if (!isAgreeTermsChecked.value) {
//           ShortMessageUtils.showError(
//               "You must agree to the terms and conditions.");
//         }
//       }
//     } catch (e) {
//       ErrorUtil.handleDatabaseErrors(e);
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
