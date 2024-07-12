import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendWorkController extends GetxController {
  final TextEditingController applicantNameController = TextEditingController();
  final TextEditingController agencyNumberController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController instrumentNumberController =
      TextEditingController();
  final TextEditingController pieceNumberController = TextEditingController();
  final TextEditingController chartNumberController = TextEditingController();
  final TextEditingController regionController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController neighborhoodController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController electronicSignatureController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController northBoundariesByNatureController =
      TextEditingController();
  final TextEditingController northBoundariesByPlanController =
      TextEditingController();
  final TextEditingController eastBoundariesByPlanController =
      TextEditingController();
  final TextEditingController southBoundariesByPlanController =
      TextEditingController();
  final TextEditingController westBoundariesByPlanController =
      TextEditingController();
  final TextEditingController northBoundariesByNatureHeightController =
      TextEditingController();
  final TextEditingController northBoundaryByDeadController =
      TextEditingController();
  final TextEditingController northBoundaryByDeadHeightController =
      TextEditingController();

  final TextEditingController northBoundaryByPlanHeightController =
      TextEditingController();

  // East direction
  final TextEditingController eastBoundariesByNatureController =
      TextEditingController();
  final TextEditingController eastBoundariesByNatureHeightController =
      TextEditingController();
  final TextEditingController eastBoundaryByDeadController =
      TextEditingController();
  final TextEditingController eastBoundaryByDeadHeightController =
      TextEditingController();
  final TextEditingController eastBoundaryByPlanHeightController =
      TextEditingController();

  // South direction
  final TextEditingController southBoundariesByNatureController =
      TextEditingController();
  final TextEditingController southBoundariesByNatureHeightController =
      TextEditingController();
  final TextEditingController southBoundaryByDeadController =
      TextEditingController();
  final TextEditingController southBoundaryByDeadHeightController =
      TextEditingController();
  final TextEditingController southBoundaryByPlanHeightController =
      TextEditingController();

  // West direction
  final TextEditingController westBoundariesByNatureController =
      TextEditingController();
  final TextEditingController westBoundariesByNatureHeightController =
      TextEditingController();
  final TextEditingController westBoundaryByDeadController =
      TextEditingController();
  final TextEditingController westBoundaryByDeadHeightController =
      TextEditingController();
  final TextEditingController westBoundaryByPlanHeightController =
      TextEditingController();

  var selectedApplicantType = 'Owner'.obs;

  void selectedApplicant(String option) {
    selectedApplicantType.value = option;
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

  var isAgreeTermsChecked = false.obs;
  var isAccurateInfoChecked = false.obs;
  var isPayDuesChecked = false.obs;

  void toggleSellerAgreeTerms(bool? value) {
    isAgreeTermsChecked.value = value ?? false;
  }

  void toggleSellerAccurateInfo(bool? value) {
    isAccurateInfoChecked.value = value ?? false;
  }

  void toggleSellerPayDues(bool? value) {
    isPayDuesChecked.value = value ?? false;
  }

  bool get areAllSellerChecked =>
      isAgreeTermsChecked.value &&
      isAccurateInfoChecked.value &&
      isPayDuesChecked.value;
  void clearAllFields() {
    applicantNameController.clear();
    agencyNumberController.clear();
    idNumberController.clear();
    instrumentNumberController.clear();
    pieceNumberController.clear();
    chartNumberController.clear();
    regionController.clear();
    cityController.clear();
    neighborhoodController.clear();
    streetController.clear();
    electronicSignatureController.clear();
    northBoundariesByNatureController.clear();
    northBoundariesByNatureHeightController.clear();
    northBoundaryByDeadController.clear();
    northBoundaryByDeadHeightController.clear();
    northBoundaryByPlanHeightController.clear();

    // East direction
    eastBoundariesByNatureController.clear();
    eastBoundariesByNatureHeightController.clear();
    eastBoundaryByDeadController.clear();
    eastBoundaryByDeadHeightController.clear();
    eastBoundaryByPlanHeightController.clear();

    // South direction
    southBoundariesByNatureController.clear();
    southBoundariesByNatureHeightController.clear();
    southBoundaryByDeadController.clear();
    southBoundaryByDeadHeightController.clear();
    southBoundaryByPlanHeightController.clear();

    // West direction
    westBoundariesByNatureController.clear();
    westBoundariesByNatureHeightController.clear();
    westBoundaryByDeadController.clear();
    westBoundaryByDeadHeightController.clear();
    westBoundaryByPlanHeightController.clear();
  }
}
