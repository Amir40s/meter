import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConsolationDeliveryController extends GetxController {
  var consultationTitleController = TextEditingController();
  var consultationController = TextEditingController();
  var applicantNameController = TextEditingController();
  var electronicSignatureController = TextEditingController();

  var selectedConsolationType = "Real estate".obs;

  void typeOfConsolation(String value) {
    selectedConsolationType.value = value;
  }

  var isAgreeTermsChecked = false.obs;
  var isAccurateInfoChecked = false.obs;
  var isPayDuesChecked = false.obs;

  void toggleAgreeTerms(bool? value) {
    isAgreeTermsChecked.value = value ?? false;
  }

  void toggleAccurateInfo(bool? value) {
    isAccurateInfoChecked.value = value ?? false;
  }

  void togglePayDues(bool? value) {
    isPayDuesChecked.value = value ?? false;
  }

  void clearFields() {
    consultationTitleController.clear();
    consultationController.clear();
    applicantNameController.clear();
    electronicSignatureController.clear();
  }
}
