// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:meter/constant/phoneUtils/phone_utils.dart';
//
// import '../../constant/DB/collection_utils.dart';
//
//
// class CustomerAuthController extends GetxController {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController neighborhoodController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();
//   final otpController = TextEditingController();
//   RxList neighborhoods = [].obs;
//   RxList cities = [].obs;
//
//   // Future<void> fetchNeighborhoods() async {
//   //   try {
//   //     QuerySnapshot querySnapshot =
//   //         await CollectionUtils.neighborhoodCollection.get();
//   //
//   //     neighborhoods.clear();
//   //
//   //     for (var doc in querySnapshot.docs) {
//   //       neighborhoods.add(doc['name']);
//   //     }
//   //     log("Neighborhood ${neighborhoods}");
//   //   } catch (e) {
//   //     print('Error fetching neighborhoods: $e');
//   //   }
//   // }
//
//   // Future<void> fetchCities() async {
//   //   try {
//   //     QuerySnapshot querySnapshot = await CollectionUtils.cityCollection.get();
//   //
//   //     // Clear existing list
//   //     cities.clear();
//   //
//   //     // Add names to the list
//   //     for (var doc in querySnapshot.docs) {
//   //       cities.add(doc['name']);
//   //     }
//   //     print("Cities are $cities");
//   //   } catch (e) {
//   //     print('Error fetching neighborhoods: $e');
//   //   }
//   // }
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     // fetchCities();
//    // fetchNeighborhoods();
//   }
//
//   void onChangeCity(String newValue) {
//     cityController.text = newValue;
//   }
//
//   void onChangeNeighborhood(String newValue) {
//     neighborhoodController.text = newValue;
//   }
//
//   void clearAllFields() {
//     nameController.clear();
//     emailController.clear();
//     cityController.clear();
//     addressController.clear();
//     neighborhoodController.clear();
//     passwordController.clear();
//     confirmPasswordController.clear();
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
//   String fullPhoneNumber() {
//     return "${countryCode.value}${phoneNumberController.text}";
//   }
//
//   bool validatePhoneNumber() {
//     return AuthUtil.validatePhoneNumber(fullPhoneNumber(), countryCode.value);
//   }
//
//   bool get areBothPasswordEqual =>
//       passwordController.text == confirmPasswordController.text;
//   final TextEditingController phoneNumberController = TextEditingController();
//
//   RxString imagePath = "".obs;
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
//         bool isAlready = await PhoneUtil.checkPhoneNumberExist(
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
//   RxBool customerLoading = false.obs;
//
//   Future<void> completeCustomerRegistration(
//       GlobalKey<FormState> formKey) async {
//     customerLoading.value = true;
//     if (formKey.currentState!.validate() &&
//         areBothPasswordEqual &&
//         isAgreeTermsChecked.value) {
//       String imageUrl = await ImageUtil.uploadToDatabase(imagePath.value);
//       String userId = DbUtil.getAutoUid()!;
//       // String fileUrl = await ImageUtil.uploadToDatabase(pdfFilePath.value);
//       AuthModel authModel = AuthModel(
//           isFaceVerify: false,
//           isFingerVerify: false,
//           userId: userId,
//           role: ConstantUtil.customer,
//           serviceProvider: "",
//           facilityName: "",
//           facilityNumber: "",
//           commercialRegistration: "",
//           facilityActivity: "",
//           ownerName: nameController.text,
//           phoneNumber: fullPhoneNumber(),
//           managerName: "",
//           managerPhoneNumber: "",
//           descriptionOfServices: "",
//           profilePicture: imageUrl,
//           region: "",
//           city: cityController.text,
//           neighborhood: neighborhoodController.text,
//           location: addressController.text,
//           long: "50.34",
//           lat: "45.44",
//           password: passwordController.text,
//           fileUrl: "",
//           email: emailController.text);
//       log("Auth model ${authModel.toJson()}");
//       await AuthUtil.userCollection.doc(userId).set(authModel.toJson());
//       PrefUtil.setString(PrefUtil.userId, userId);
//       Get.offAllNamed(RoutesName.sellerFaceAuth);
//       // Get.offAll(const SellerFaceAuth());
//       // await authenticatePhoneNumber(context);
//       PrefUtil.setString(PrefUtil.role, "Customer");
//       // Get.to(const SellerFaceAuth());
//     } else {
//       if (!areBothPasswordEqual) {
//         ShortMessageUtils.showError("Both password must be equal");
//         customerLoading.value = false;
//       } else if (!isAgreeTermsChecked.value) {
//         ShortMessageUtils.showError("You should agree all agreements");
//         customerLoading.value = false;
//       } else {
//         ShortMessageUtils.showError("Please fill all fields");
//         customerLoading.value = false;
//       }
//     }
//     // PrefUtil.setString(PrefUtil.role, "Customer");
//     // Get.to(const SellerFaceAuth());
//   }
//
//   // RxString verificationId =
//   //     ''.obs; // Stores the verification ID received from Firebase Auth.
//   // RxInt? resendToken = RxInt(0);
//   // RxBool showResend = true.obs;
//   // RxBool customerLoading = false.obs;
//   // void startResendTimer(BuildContext context) {
//   //   showResend.value = false; // Hide resend button
//   //   authenticatePhoneNumber(context);
//   //   Timer(const Duration(seconds: 60), () {
//   //     showResend.value = true; // Show resend button after 60 seconds
//   //   });
//   // }
//   //
//   // RxBool verifyOtpLoading = false.obs;
//   //
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
//   //         Get.off(
//   //             const CustomerVerify()); // Navigates to OTP screen for user input.
//   //         customerLoading.value = false;
//   //         // sellerLoading.value = false;
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
//   //     customerLoading.value = false;
//   //     // sellerLoading.value = false;
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
//   //       print("User uid is ${user.uid}");
//   //       String imageUrl = await ImageUtil.uploadToDatabase(imagePath.value);
//   //       // String fileUrl = await ImageUtil.uploadToDatabase(pdfFilePath.value);
//   //       AuthModel authModel = AuthModel(
//   //           isFaceVerify: false,
//   //           isFingerVerify: false,
//   //           userId: user.uid,
//   //           role: ConstantUtil.provider,
//   //           serviceProvider: "",
//   //           facilityName: "",
//   //           facilityNumber: "",
//   //           commercialRegistration: "",
//   //           facilityActivity: "",
//   //           ownerName: nameController.text,
//   //           phoneNumber: fullPhoneNumber(),
//   //           managerName: "",
//   //           managerPhoneNumber: "",
//   //           descriptionOfServices: "",
//   //           profilePicture: imageUrl,
//   //           region: "",
//   //           city: cityController.text,
//   //           neighborhood: neighborhoodController.text,
//   //           location: addressController.text,
//   //           long: "",
//   //           lat: "",
//   //           password: passwordController.text,
//   //           fileUrl: "",
//   //           email: emailController.text);
//   //       log("Auth model ${authModel.toJson()}");
//   //       await AuthUtil.userCollection.doc(user.uid).set(authModel.toJson());
//   //       log("Here it is going");
//   //       // Get.offAllNamed(RoutesName.sellerFaceAuth);
//   //       Get.offAll(const SellerFaceAuth());
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
