import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAccountController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController neighborhoodController = TextEditingController();

  void clearAllFields() {
    nameController.clear();
    emailController.clear();
    cityController.clear();
    neighborhoodController.clear();
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

  final TextEditingController phoneNumberController = TextEditingController();
}
