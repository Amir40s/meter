// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/get_rx.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:meter_app/model/requestServices/request_services_model.dart';
// import 'package:meter_app/services/db_services.dart';
// import 'package:meter_app/utils/backend_util/dbutil.dart';
// import 'package:meter_app/utils/backend_util/error_util.dart';
// import 'package:meter_app/utils/backend_util/image_util.dart';
// import 'package:meter_app/utils/backend_util/constant_util.dart';
// import 'package:meter_app/utils/short_message_utils.dart';
// import 'package:meter_app/view/bottom_nav/bottom_nav_main.dart';
// import 'package:meter_app/widget/success.dart';
//
// import '../../../utils/backend_util/auth_util.dart';
//
// class RequestServiceController extends GetxController {
//   var selectedRadio =
//       "request_service".obs; // Observable for selected radio value
//
//   void setSelectedRadio(String value) {
//     selectedRadio.value = value;
//   }
//
//   RxString searchValue = "".obs;
//
//   void onChangeSearch(newValue) {
//     searchValue.value = newValue;
//   }
//
//   var isPayMeterChecked = false.obs;
//   var isAccuracyChecked = false.obs;
//   var isAgreeTermsChecked = false.obs;
//   bool get isAllChecked =>
//       isAgreeTermsChecked.value &&
//       isPayMeterChecked.value &&
//       isAccuracyChecked.value;
//   void toggleAgreeTerms(bool? value) {
//     isAgreeTermsChecked.value = value ?? false;
//   }
//
//   void togglePayMeter(bool? value) {
//     isPayMeterChecked.value = value ?? false;
//   }
//
//   void toggleAccuracyChecked(bool? value) {
//     isAccuracyChecked.value = value ?? false;
//   }
//
//   var selectedTypeOfCertificate = "Residential".obs;
//
//   void typeOfCertificate(String value) {
//     selectedTypeOfCertificate.value = value;
//   }
//
//   var selectedTypeOfApplicant = "Owner".obs;
//
//   void typeOfApplicant(String value) {
//     print("Selected type is ${selectedTypeOfApplicant.value}");
//     if (selectedTypeOfApplicant.value != value) {
//       selectedTypeOfApplicant.value = value;
//       typeOfOtherController.text = value;
//     } else {
//       selectedTypeOfApplicant.value = "";
//     }
//   }
//
//   RxString selectedPurpose = "Survey report".obs;
//
//   final List purposeOfPricingList = [
//     "Survey report",
//     "Building conformity certificate",
//     "Construction completion certificate",
//     "Construction license",
//     "Correcting the condition of an existing building",
//     "Building compliance certificate",
//     "Occupancy certificate"
//   ];
//   void selectPurposeOfPricing(String value) {
//     selectedPurpose.value = value;
//     purposeOfPricingController.text = value;
//   }
//
//   RxString selectedSurveyReport = "Issuing a building permit".obs;
//   final List purposeOfSurveyReportList = [
//     "Issuing a building permit",
//     "Expropriation",
//     "Emptying",
//     "Digging well",
//     "Request to sort real estate units",
//     "Sorting built-up lands (duplexes)",
//   ];
//   void selectPurposeOfSurveyReport(String value) {
//     selectedSurveyReport.value = value;
//     purposeOfSurveyReportController.text = value;
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
//   final TextEditingController purposeOfPricingController =
//       TextEditingController();
//   final TextEditingController purposeOfSurveyReportController =
//       TextEditingController();
//
//   final TextEditingController phoneNumberController = TextEditingController();
//
//   final TextEditingController surveyReportNumberController =
//       TextEditingController();
//   final TextEditingController instrumentNumberController =
//       TextEditingController();
//   final TextEditingController typeOfOtherController = TextEditingController();
//   final TextEditingController regionController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController neighborhoodController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();
//   final TextEditingController pieceNumberController = TextEditingController();
//   final TextEditingController chartNumberController = TextEditingController();
//   final TextEditingController agencyNumberController = TextEditingController();
//   final TextEditingController applicantsNameController =
//       TextEditingController();
//   final TextEditingController idNumberController = TextEditingController();
//
//   RxBool loading = false.obs;
//   RxString filePath = "".obs;
//   RxString fileName = "".obs;
//   String fullPhoneNumber() {
//     return "${countryCode.value}${phoneNumberController.text}";
//   }
//
//   bool validatePhoneNumber() {
//     return AuthUtil.validatePhoneNumber(fullPhoneNumber(), countryCode.value);
//   }
//
//   Future<void> onContinueClick(GlobalKey<FormState> _formKey) async {
//     try {
//       loading.value = true;
//       if (_formKey.currentState!.validate() &&
//           isAllChecked &&
//           validatePhoneNumber() &&
//           filePath.value != "") {
//         String fileUrl = await ImageUtil.uploadToDatabase(filePath.value);
//         RequestServicesModel requestServicesModel = RequestServicesModel(
//           id: DbUtil.getAutoUid()!,
//           role: ConstantUtil.customer,
//           userUID: DbUtil.getCurrentUid()!,
//           pricingPurpose: purposeOfPricingController.text,
//           surveyReport: purposeOfSurveyReportController.text,
//           reportNumber: surveyReportNumberController.text,
//           instrumentNumber: instrumentNumberController.text,
//           region: regionController.text,
//           city: cityController.text,
//           neighborhood: neighborhoodController.text,
//           location: locationController.text,
//           pieceNumber: pieceNumberController.text,
//           chartNumber: chartNumberController.text,
//           applicationType: selectedTypeOfApplicant.value,
//           applicationName: applicantsNameController.text,
//           phoneNumber: fullPhoneNumber(),
//           activityType: ConstantUtil.requestService,
//           idNumber: idNumberController.text,
//           agencyNumber: agencyNumberController.text,
//           documentImage: fileUrl,
//         );
//         await DbServices.addRequestService(requestServicesModel);
//         Get.bottomSheet(
//           isDismissible: false,
//           enableDrag: false,
//           CustomSuccessScreen(
//             title: "Post Request",
//             buttonTitle: "Done",
//             desc:
//                 "Your request has been posted. Click to show providers proposals",
//             onDoneTap: () {
//               Get.offAll(const BottomNavMain());
//             },
//           ),
//         );
//       } else {
//         if (!isAllChecked) {
//           ShortMessageUtils.showError("You must checked all agreements");
//         } else if (!validatePhoneNumber()) {
//           ShortMessageUtils.showError("Please enter valid phone number");
//         } else if (filePath.value == "") {
//           ShortMessageUtils.showError("Please Upload file");
//         } else {
//           ShortMessageUtils.showError("Please enter all fields");
//         }
//       }
//     } catch (e) {
//       ErrorUtil.handleDatabaseErrors(e);
//     } finally {
//       loading.value = false;
//     }
//   }
//
//   void clearAllFields() {
//     purposeOfPricingController.clear();
//     purposeOfSurveyReportController.clear();
//     surveyReportNumberController.clear();
//     instrumentNumberController.clear();
//     typeOfOtherController.clear();
//     regionController.clear();
//     cityController.clear();
//     neighborhoodController.clear();
//     locationController.clear();
//     pieceNumberController.clear();
//     chartNumberController.clear();
//     agencyNumberController.clear();
//     applicantsNameController.clear();
//     idNumberController.clear();
//   }
//   ////////////////Consolation//////////////////////
// }
