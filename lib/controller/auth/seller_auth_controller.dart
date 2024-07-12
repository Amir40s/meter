// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/get_rx.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/state_manager.dart';
// import 'package:meter_app/model/auth/auth_model.dart';
// import 'package:meter_app/services/api_services.dart';
// import 'package:meter_app/utils/backend_util/auth_util.dart';
// import 'package:meter_app/utils/backend_util/collection_utils.dart';
// import 'package:meter_app/utils/backend_util/dbutil.dart';
// import 'package:meter_app/utils/backend_util/error_util.dart';
// import 'package:meter_app/utils/backend_util/image_util.dart';
// import 'package:meter_app/utils/backend_util/constant_util.dart';
// import 'package:meter_app/utils/pref_util.dart';
// import 'package:meter_app/utils/short_message_utils.dart';
// import 'package:meter_app/utils/useful_function_util.dart';
// import 'package:meter_app/view/auth/Signup/seller_login/face_auth.dart';
// import 'package:meter_app/view/auth/Signup/seller_login/seller_verify.dart';
//
// import '../../widget/backend/verification_bottom_sheet.dart';
//
// class SellerAuthController extends GetxController {
//   var selectedSellerServiceOption =
//       'Company'.obs; // Observable to track the selected option
//   final TextEditingController facilityNameController = TextEditingController();
//   final TextEditingController facilityActivityController =
//       TextEditingController();
//   final TextEditingController facilityNumberController =
//       TextEditingController();
//   final TextEditingController commercialRegistrationController =
//       TextEditingController();
//   final TextEditingController ownerNameController = TextEditingController();
//   final TextEditingController managerNameController = TextEditingController();
//   final TextEditingController descriptionOfServiceController =
//       TextEditingController();
//   final TextEditingController regionController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController neighborhoodController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();
//   final TextEditingController otpController = TextEditingController();
//
//   RxString pdfFilePath = "".obs;
//   RxString pdfFileName = "".obs;
//
//   RxBool passwordHide = true.obs;
//   void togglePassword() {
//     passwordHide.value = !passwordHide.value;
//   }
//
//   RxBool confirmPasswordHide = true.obs;
//   bool isBothPasswordEqual() {
//     return passwordController.text == confirmPasswordController.text;
//   }
//
//   void toggleConfirmPassword() {
//     confirmPasswordHide.value = !confirmPasswordHide.value;
//   }
//
//   void clearAllFields() {
//     facilityNameController.clear();
//     facilityNumberController.clear();
//     commercialRegistrationController.clear();
//     ownerNameController.clear();
//     managerNameController.clear();
//     descriptionOfServiceController.clear();
//     regionController.clear();
//     cityController.clear();
//     neighborhoodController.clear();
//     locationController.clear();
//     passwordController.clear();
//     confirmPasswordController.clear();
//   }
//
//   void selectSellerServiceOption(String option) {
//     selectedSellerServiceOption.value = option;
//   }
//
//   var isSellerAgreeTermsChecked = false.obs;
//   var isSellerAccurateInfoChecked = false.obs;
//   var isSellerPayDuesChecked = false.obs;
//
//   void toggleSellerAgreeTerms(bool? value) {
//     isSellerAgreeTermsChecked.value = value ?? false;
//   }
//
//   void toggleSellerAccurateInfo(bool? value) {
//     isSellerAccurateInfoChecked.value = value ?? false;
//   }
//
//   void toggleSellerPayDues(bool? value) {
//     isSellerPayDuesChecked.value = value ?? false;
//   }
//
//   RxList neighborhoods = [].obs;
//   RxList cities = [].obs;
//
//   Future<void> fetchNeighborhoods() async {
//     try {
//       QuerySnapshot querySnapshot =
//           await CollectionUtils.neighborhoodCollection.get();
//
//       neighborhoods.clear();
//
//       for (var doc in querySnapshot.docs) {
//         neighborhoods.add(doc['name']);
//       }
//       log("Neighborhood ${neighborhoods}");
//     } catch (e) {
//       print('Error fetching neighborhoods: $e');
//     }
//   }
//
//   Future<void> fetchCities() async {
//     try {
//       QuerySnapshot querySnapshot = await CollectionUtils.cityCollection.get();
//
//       // Clear existing list
//       cities.clear();
//
//       // Add names to the list
//       for (var doc in querySnapshot.docs) {
//         cities.add(doc['name']);
//       }
//       print("Cities are $cities");
//     } catch (e) {
//       print('Error fetching neighborhoods: $e');
//     }
//   }
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     fetchNeighborhoods();
//     fetchCities();
//   }
//
//   bool get areAllSellerChecked =>
//       isSellerAgreeTermsChecked.value &&
//       isSellerAccurateInfoChecked.value &&
//       isSellerPayDuesChecked.value;
//
//   RxString phoneNumberFlagUri = "flags/sa.png".obs;
//   RxString phoneNumberCountryCode = "+966".obs;
//   RxString phoneNumberCountryShortCode = "SA".obs;
//
//   String fullPhoneNumber() {
//     return "${phoneNumberCountryCode.value}${phoneNumberController.text}";
//   }
//
//   void onChangePhoneNumberFlag(String changedUri, String code, String country) {
//     phoneNumberFlagUri.value = changedUri; // Update the flag image URI.
//     phoneNumberCountryCode.value = code; // Update the country code.
//     phoneNumberCountryShortCode.value =
//         country; // Update the country's short code.
//     print("$code $country");
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
//   RxBool sendOtpLoading = false.obs;
//   RxString message = "".obs;
//   RxInt codeId = 0.obs;
//   RxBool showResendValue = true.obs;
//   RxBool isBottomSheetAlreadyOpen = false.obs;
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
//   String fullManagerPhoneNumber() {
//     return "${managerPhoneNumberCountryCode.value}${managerPhoneNumberController.text}";
//   }
//
//   final TextEditingController phoneNumberController = TextEditingController();
//   final TextEditingController managerPhoneNumberController =
//       TextEditingController();
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
//   RxString imagePath = "".obs;
//
//   void onChangeCity(String newValue) {
//     cityController.text = newValue;
//     print("New Value $newValue ${cityController.text}");
//   }
//
//   void onChangeNeighborhood(String newValue) {
//     neighborhoodController.text = newValue;
//   }
//
//   RxBool sellerLoading = false.obs;
//
//   Future<void> sellerCompleteRegister(
//     BuildContext context, {
//     formKey,
//     uid,
//   }) async {
//     try {
//       sellerLoading.value = true;
//       print("Is ${isBothPasswordEqual()}");
//       if (formKey.currentState!.validate() &&
//           isBothPasswordEqual() &&
//           areAllSellerChecked &&
//           pdfFilePath.value != "") {
//         bool phoneNumberAlreadyExist = await AuthUtil.checkPhoneNumberExist(
//             phoneNumber: fullPhoneNumber());
//         if (!phoneNumberAlreadyExist) {
//           String imageUrl = await ImageUtil.uploadToDatabase(imagePath.value);
//           String fileUrl = await ImageUtil.uploadToDatabase(pdfFilePath.value);
//           String userId = DbUtil.getAutoUid()!;
//           AuthModel authModel = AuthModel(
//               isFaceVerify: false,
//               isFingerVerify: false,
//               userId: userId,
//               role: ConstantUtil.seller,
//               serviceProvider: selectedSellerServiceOption.value,
//               facilityName: facilityNameController.text,
//               facilityNumber: facilityNumberController.text,
//               commercialRegistration: commercialRegistrationController.text,
//               facilityActivity: facilityActivityController.text,
//               ownerName: ownerNameController.text,
//               phoneNumber: fullPhoneNumber(),
//               managerName: managerNameController.text,
//               managerPhoneNumber: fullManagerPhoneNumber(),
//               descriptionOfServices: descriptionOfServiceController.text,
//               profilePicture: imageUrl,
//               region: regionController.text,
//               city: cityController.text,
//               neighborhood: neighborhoodController.text,
//               location: locationController.text,
//               long: "50.8194",
//               lat: "56.892",
//               password: passwordController.text,
//               fileUrl: fileUrl,
//               email: '');
//           await AuthUtil.userCollection.doc(userId).set(authModel.toJson());
//           print("UserId is $userId");
//           PrefUtil.setString(PrefUtil.userId, userId);
//           Get.offAll(const SellerFaceAuth());
//           // await authenticatePhoneNumber(context);
//         } else {
//           sellerLoading.value = false;
//           ShortMessageUtils.showError("Phone number already exist");
//         }
//       } else {
//         if (!isBothPasswordEqual()) {
//           sellerLoading.value = false;
//
//           ShortMessageUtils.showError("Both password must be equal");
//         } else if (!areAllSellerChecked) {
//           ShortMessageUtils.showError("You should agree all agreements");
//           sellerLoading.value = false;
//         } else if (pdfFilePath.value == "") {
//           ShortMessageUtils.showError("Please upload file");
//           sellerLoading.value = false;
//         } else {
//           ShortMessageUtils.showError("Please fill all fields");
//           sellerLoading.value = false;
//         }
//       }
//     } finally {}
//   }
//
//   RxString verificationId =
//       ''.obs; // Stores the verification ID received from Firebase Auth.
//   RxInt? resendToken = RxInt(0);
//   RxBool showResend = true.obs;
//   void startResendTimer(BuildContext context) {
//     showResend.value = false; // Hide resend button
//     authenticatePhoneNumber(context);
//     Timer(const Duration(seconds: 60), () {
//       showResend.value = true; // Show resend button after 60 seconds
//     });
//   }
//
//   RxBool verifyOtpLoading = false.obs;
//
//   Future<void> authenticatePhoneNumber(BuildContext context) async {
//     FirebaseAuth _auth = FirebaseAuth.instance;
//     try {
//       await _auth.verifyPhoneNumber(
//         // phoneNumber: "+923056022699",
//         phoneNumber: fullPhoneNumber(),
//         // Constructs the full phone number.
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           // Auto-sign-in completion callback.
//           await _auth.signInWithCredential(credential);
//           print("Phone Number is ${fullPhoneNumber()}");
//           print("Authentication successful.");
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           log("Error is $e");
//           // Verification failure callback.
//           ErrorUtil.handleOtpFailure(e);
//         },
//         codeSent: (String verificationIdReceived, int? resendTokenReceived) {
//           verificationId.value = verificationIdReceived;
//           if (resendTokenReceived != null) {
//             resendToken!.value = resendTokenReceived;
//           }
//           // showResend.value = false;
//           // startResendTimer(context);
//           Get.off(
//               const SellerVerifyScreen()); // Navigates to OTP screen for user input.
//           sellerLoading.value = false;
//         },
//         codeAutoRetrievalTimeout: (String verificationIdReceived) {
//           // Auto-retrieval timeout callback.
//           verificationId.value = verificationIdReceived;
//         },
//         timeout: const Duration(seconds: 60),
//         forceResendingToken: resendToken?.value,
//       );
//     } catch (e) {
//       print('An unexpected error occurred: $e');
//       sellerLoading.value = false;
//     }
//   }
//
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
//   //       print("User uid is ${user.uid}");
//   //       String imageUrl = await ImageUtil.uploadToDatabase(imagePath.value);
//   //       String fileUrl = await ImageUtil.uploadToDatabase(pdfFilePath.value);
//   //       AuthModel authModel = AuthModel(
//   //           isFaceVerify: false,
//   //           isFingerVerify: false,
//   //           userId: user.uid,
//   //           role: ConstantUtil.seller,
//   //           serviceProvider: selectedSellerServiceOption.value,
//   //           facilityName: facilityNameController.text,
//   //           facilityNumber: facilityNumberController.text,
//   //           commercialRegistration: commercialRegistrationController.text,
//   //           facilityActivity: facilityActivityController.text,
//   //           ownerName: ownerNameController.text,
//   //           phoneNumber: fullPhoneNumber(),
//   //           managerName: managerNameController.text,
//   //           managerPhoneNumber: fullManagerPhoneNumber(),
//   //           descriptionOfServices: descriptionOfServiceController.text,
//   //           profilePicture: imageUrl,
//   //           region: regionController.text,
//   //           city: cityController.text,
//   //           neighborhood: neighborhoodController.text,
//   //           location: locationController.text,
//   //           long: "50.8194",
//   //           lat: "56.892",
//   //           password: passwordController.text,
//   //           fileUrl: fileUrl,
//   //           email: '');
//   //       log("Auth model ${authModel.toJson()}");
//   //       await AuthUtil.userCollection.doc(user.uid).set(authModel.toJson());
//   //       log("Here it is going");
//   //       // Get.offAllNamed(RoutesName.sellerFaceAuth);
//   //       Get.offAll(SellerFaceAuth());
//   //
//   //       ///Navigation here
//   //     } else {
//   //       log("User is null.");
//   //     }
//   //   } catch (e) {
//   //     log(e.toString());
//   //     ErrorUtil.handleOtpErrors(e); // Handles OTP verification errors.
//   //   } finally {
//   //     verifyOtpLoading.value = false;
//   //   }
//   // }
// }
