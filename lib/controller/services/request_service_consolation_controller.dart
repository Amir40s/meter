import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/bottomSheet/success/success_bottom_sheet.dart';
import 'package:meter/constant/phoneUtils/phone_utils.dart';
import 'package:meter/constant/prefUtils/message_utills.dart';
import 'package:meter/constant/routes/routes_name.dart';
import 'package:meter/controller/account/profile_controller.dart';
import 'package:meter/services/request/request_services.dart';

import '../../constant.dart';
import '../../constant/errorUtills/error_utils.dart';
import '../../constant/errorUtills/image_utils.dart';
import '../../model/requestServices/request_services_model.dart';

class RequestServiceConsolationController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController applicantNameController = TextEditingController();
  final TextEditingController regionController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController neighborhoodController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController longitude = TextEditingController();
  final TextEditingController latitude = TextEditingController();
  final consolationFormKey = GlobalKey<FormState>();

  var selectedTypeOfConsolation = "Real estate".obs;

  RxString flagUri = "flags/sa.png".obs;
  RxString countryCode = "+966".obs;
  RxString countryShortCode = "SA".obs;

  void onChangeFlag(String changedUri, String code, String country) {
    flagUri.value = changedUri; // Update the flag image URI.
    countryCode.value = code; // Update the country code.
    countryShortCode.value = country; // Update the country's short code.
    log("$code $country");
  }

  String fullPhoneNumber() {
    return "${countryCode.value}${phoneNumberController.text}";
  }

  bool validatePhoneNumber() {
    return PhoneUtil.validatePhoneNumber(fullPhoneNumber(), countryCode.value);
  }

  void selectTypeOfConsolation(String value) {
    selectedTypeOfConsolation.value = value;
  }

  var isPayMeterChecked = false.obs;
  var isAccuracyChecked = false.obs;
  var isAgreeTermsChecked = false.obs;

  bool get isAllChecked =>
      isAgreeTermsChecked.value &&
      isPayMeterChecked.value &&
      isAccuracyChecked.value;
  void toggleAgreeTerms(bool? value) {
    isAgreeTermsChecked.value = value ?? false;
  }

  void togglePayMeter(bool? value) {
    isPayMeterChecked.value = value ?? false;
  }

  void toggleAccuracyChecked(bool? value) {
    isAccuracyChecked.value = value ?? false;
  }

  RxBool loading = false.obs;
  RxBool requestLoading = false.obs;
  RxString filePath = "".obs;
  RxString fileName = "".obs;
  Future<void> onClickContinue(GlobalKey<FormState> _formKey) async {
    try {
      requestLoading.value = true;
      if (_formKey.currentState!.validate() &&
          isAllChecked &&
          filePath.value != "") {
        String fileUrl = await ImageUtil.uploadToDatabase(filePath.value);
        final controller = Get.find<ProfileController>();
        final user = controller.user.value;
        RequestServicesModel requestServicesModel = RequestServicesModel(
            userProfileImage: user.profilePicture,
            long: longitude.text,
            lat: latitude.text,
            userName: user.ownerName,
            id: getAutoUid()!,
            role: customer,
            userUID: getCurrentUid()!,
            consolationTitle: titleController.text,
            consolationType: selectedTypeOfConsolation.value,
            details: detailsController.text,
            applicationName: applicantNameController.text,
            phoneNumber: fullPhoneNumber(),
            region: regionController.text,
            city: cityController.text,
            neighborhood: neighborhoodController.text,
            location: locationController.text,
            documentImage: fileUrl,
            activityType: consolation);
        await RequestServices.addRequestService(requestServicesModel);
        Get.bottomSheet(
            isDismissible: false,
            enableDrag: false,
            SuccessBottomSheet(
              title: "Post Request",
              buttonTitle: "Done",
              desc:
                  "Your request has been posted. Click to show providers proposals",
              onDoneTap: () {
                clearAllFields();
                Get.offAllNamed(RoutesName.bottomNavMain);
              },
            ));
      } else {
        if (!isAllChecked) {
          ShortMessageUtils.showError("You must checked all agreements");
        } else if (filePath.value == "") {
          ShortMessageUtils.showError("Please Upload file");
        } else {
          ShortMessageUtils.showError("Please enter all fields");
        }
      }
    } catch (e) {
      ErrorUtil.handleDatabaseErrors(e);
    } finally {
      requestLoading.value = false;
    }
  }

  void clearAllFields() {
    titleController.clear();
    detailsController.clear();
    applicantNameController.clear();
    regionController.clear();
    cityController.clear();
    neighborhoodController.clear();
    locationController.clear();
  }
}
