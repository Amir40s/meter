import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meter/constant/CollectionUtils/collection_utils.dart';
import 'package:meter/constant/phoneUtils/phone_utils.dart';
import 'package:meter/http/api/otp_api_services.dart';
import 'package:meter/model/user/user_model.dart';

import '../../bottomSheet/verification/verification_bottom_sheet.dart';
import '../../constant.dart';
import '../../constant/errorUtills/image_utils.dart';
import '../../constant/prefUtils/message_utills.dart';
import '../../constant/prefUtils/pref_utils.dart';
import '../../constant/routes/routes_name.dart';
import '../account/profile_controller.dart';
import '../bottomNav/bottom_nav_controller_main.dart';
import '../home/home_controller.dart';

class CustomerAuthController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController neighborhoodController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final otpController = TextEditingController();
  RxList neighborhoods = [].obs;
  RxList cities = [].obs;

  // Future<void> fetchNeighborhoods() async {
  //   try {
  //     QuerySnapshot querySnapshot =
  //         await CollectionUtils.neighborhoodCollection.get();
  //
  //     neighborhoods.clear();
  //
  //     for (var doc in querySnapshot.docs) {
  //       neighborhoods.add(doc['name']);
  //     }
  //     log("Neighborhood ${neighborhoods}");
  //   } catch (e) {
  //     print('Error fetching neighborhoods: $e');
  //   }
  // }

  // Future<void> fetchCities() async {
  //   try {
  //     QuerySnapshot querySnapshot = await CollectionUtils.cityCollection.get();
  //
  //     // Clear existing list
  //     cities.clear();
  //
  //     // Add names to the list
  //     for (var doc in querySnapshot.docs) {
  //       cities.add(doc['name']);
  //     }
  //     print("Cities are $cities");
  //   } catch (e) {
  //     print('Error fetching neighborhoods: $e');
  //   }
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // fetchCities();
    // fetchNeighborhoods();
  }

  void onChangeCity(String newValue) {
    cityController.text = newValue;
  }

  void onChangeNeighborhood(String newValue) {
    neighborhoodController.text = newValue;
  }

  void clearAllFields() {
    nameController.clear();
    emailController.clear();
    cityController.clear();
    addressController.clear();
    neighborhoodController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  RxBool passwordHide = true.obs;
  void togglePassword() {
    passwordHide.value = !passwordHide.value;
  }

  RxBool confirmPasswordHide = true.obs;
  void toggleConfirmPassword() {
    confirmPasswordHide.value = !confirmPasswordHide.value;
  }

  var isAgreeTermsChecked = false.obs;

  void toggleAgreeTerms(bool? value) {
    isAgreeTermsChecked.value = value ?? false;
  }

  RxString flagUri = "flags/sa.png".obs;
  RxString countryCode = "+966".obs;
  RxString countryShortCode = "SA".obs;

  void onChangeFlag(String changedUri, String code, String country) {
    flagUri.value = changedUri; // Update the flag image URI.
    countryCode.value = code; // Update the country code.
    countryShortCode.value = country; // Update the country's short code.
    print("$code $country");
  }

  String fullPhoneNumber() {
    return "${countryCode.value}${phoneNumberController.text}";
  }

  bool validatePhoneNumber() {
    return PhoneUtil.validatePhoneNumber(fullPhoneNumber(), countryCode.value);
  }

  bool get areBothPasswordEqual =>
      passwordController.text == confirmPasswordController.text;
  final TextEditingController phoneNumberController = TextEditingController();

  RxString imagePath = "".obs;

  RxBool sendOtpLoading = false.obs;
  RxString message = "".obs;
  RxInt codeId = 0.obs;
  RxBool showResendValue = true.obs;
  RxBool isBottomSheetAlreadyOpen = false.obs;

  Future sendOtp() async {
    try {
      if (validatePhoneNumber()) {
        sendOtpLoading.value = true;
        bool isAlready = await PhoneUtil.checkPhoneNumberExist(
            phoneNumber: fullPhoneNumber());
        if (!isAlready) {
          final sendCodeResponse =
              await OtpApiServices.sendOtp(fullPhoneNumber());
          final jsonResponse = jsonDecode(sendCodeResponse.body);
          if (sendCodeResponse.statusCode == 200) {
            if (jsonResponse['code'] == 1) {
              message.value = jsonResponse["message"];
              codeId.value = jsonResponse["id"];
              ShortMessageUtils.showSuccess(jsonResponse["message"]);
              if (!isBottomSheetAlreadyOpen.value) {
                Get.bottomSheet(
                    isDismissible: false,
                    enableDrag: false,
                    Obx(
                      () => VerificationBottomSheet(
                        phoneNumber:
                            PhoneUtil.formatPhoneNumber(fullPhoneNumber()),
                        controller: otpController,
                        isLoadingVerify: verifyOneTimePasswordLoading.value,
                        showResend: showResendValue.value,
                        onResendCodeTap: () {
                          showResendValue.value = false; // Hide resend button
                          isBottomSheetAlreadyOpen.value = true;
                          sendOtp();
                          Timer(const Duration(seconds: 60), () {
                            showResendValue.value =
                                true; // Show resend button after 60 seconds
                          });
                        },
                        onVerifyTap: () {
                          verifyOtp();
                        },
                      ),
                    ));
              }
            } else {
              ShortMessageUtils.showError(jsonResponse["message"]);
              message.value = jsonResponse["message"];
            }
          } else {
            sendOtpLoading.value = false;
            ShortMessageUtils.showError(jsonResponse['message']);
            message.value = jsonResponse["message"];
          }
        } else {
          ShortMessageUtils.showError("Phone number already exist");
        }
      } else {
        ShortMessageUtils.showError("Please enter valid phone number");
      }
    } finally {
      sendOtpLoading.value = false;
      isBottomSheetAlreadyOpen.value = false;
    }
  }

  RxBool verifyOneTimePasswordLoading = false.obs;
  RxString verifyMessage = "".obs;

  Future verifyOtp() async {
    try {
      verifyOneTimePasswordLoading.value = true;
      final verifyResponse =
          await OtpApiServices.verifyCode(otpController.text, codeId.value);
      final jsonResponse = jsonDecode(verifyResponse.body);
      if (verifyResponse.statusCode == 200) {
        if (jsonResponse["code"] == 1) {
          verifyMessage.value = jsonResponse["message"];
          Get.back();
          ShortMessageUtils.showSuccess(jsonResponse["message"]);
        } else {
          // verifyMessage.value = jsonResponse["message"];
          Get.back();
          verifyMessage.value = "Success";
          ShortMessageUtils.showError(jsonResponse["message"]);
        }
      } else {
        verifyMessage.value = jsonResponse["message"];
        ShortMessageUtils.showError(jsonResponse["message"]);
      }
    } finally {
      verifyOneTimePasswordLoading.value = false;
      otpController.clear();
    }
  }

  RxBool customerLoading = false.obs;

  Future<void> completeCustomerRegistration(
      GlobalKey<FormState> formKey) async {
    customerLoading.value = true;
    if (formKey.currentState!.validate() &&
        areBothPasswordEqual &&
        isAgreeTermsChecked.value) {
      String imageUrl = await ImageUtil.uploadToDatabase(imagePath.value);
      String userId = getAutoUid()!;

      UserModel authModel = UserModel(
          isFaceVerify: false,
          isFingerVerify: false,
          userId: userId,
          role: customer,
          serviceProvider: "",
          facilityName: "",
          facilityNumber: "",
          commercialRegistration: "",
          facilityActivity: "",
          ownerName: nameController.text,
          phoneNumber: fullPhoneNumber(),
          managerName: "",
          managerPhoneNumber: "",
          descriptionOfServices: "",
          profilePicture: imageUrl,
          region: "",
          city: cityController.text,
          neighborhood: neighborhoodController.text,
          location: addressController.text,
          long: "50.34",
          lat: "45.44",
          password: passwordController.text,
          fileUrl: "",
          email: emailController.text);
      log("Auth model ${authModel.toJson()}");
      await CollectionUtils.userCollection.doc(userId).set(authModel.toJson());

      PrefUtil.setString(PrefUtil.userId, userId);
      PrefUtil.setString(PrefUtil.role, "Customer");

      Get.put(ProfileController(), permanent: true);
      final controller = Get.find<ProfileController>();
      await controller.fetchUserData(userId.toString());
      final bottomNavController =  Get.find<BottomNavController>();
      final homeController =  Get.find<HomeController>();
      log("message::${bottomNavController.currentRole.value.toString()}");
      await bottomNavController.getCurrentRole();
      await homeController.getCurrentRole();
      log("CHECK:: Customer Screen Before navigation to face auth");

      Get.offAllNamed(RoutesName.faceAuth);
    } else {
      if (!areBothPasswordEqual) {
        ShortMessageUtils.showError("Both password must be equal");
        customerLoading.value = false;
      } else if (!isAgreeTermsChecked.value) {
        ShortMessageUtils.showError("You should agree all agreements");
        customerLoading.value = false;
      } else {
        ShortMessageUtils.showError("Please fill all fields");
        customerLoading.value = false;
      }
    }
  }
}
