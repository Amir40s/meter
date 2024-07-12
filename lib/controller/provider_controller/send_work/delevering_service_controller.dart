import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveringServiceController extends GetxController {
  final serviceTypeController = TextEditingController();
  final otherController = TextEditingController();
  final applicantNameController = TextEditingController();
  final agencyNumberController = TextEditingController();
  final idNumberController = TextEditingController();
  final electronicSignatureController = TextEditingController();

  void onChangeServiceType(String newValue) {
    serviceTypeController.text = newValue;
  }

  var selectedTypeOfCertificate = "Residential".obs;

  void typeOfCertificate(String value) {
    selectedTypeOfCertificate.value = value;
  }

  var selectedTypeOfApplicant = "Owner".obs;

  void typeOfApplicant(String value) {
    selectedTypeOfApplicant.value = value;
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

  RxString selectedPurpose = "Survey report".obs;
  final List purposeOfPricingList = [
    "Survey report",
    "Building conformity certificate",
    "Construction completion certificate",
    "Construction license",
    "Correcting the condition of an existing building",
    "Building compliance certificate",
    "Occupancy certificate"
  ];
  void selectPurposeOfPricing(String value) {
    selectedPurpose.value = value;
  }

  bool get areAllChecked =>
      isAgreeTermsChecked.value &&
      isAccurateInfoChecked.value &&
      isPayDuesChecked.value;

  void clearFields() {
    serviceTypeController.clear();
    otherController.clear();
    applicantNameController.clear();
    agencyNumberController.clear();
    idNumberController.clear();
    electronicSignatureController.clear();
  }
}
