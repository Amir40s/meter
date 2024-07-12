import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:meter_app/model/requestServices/request_services_model.dart';
import 'package:meter_app/services/db_services.dart';
import 'package:meter_app/utils/backend_util/auth_util.dart';
import 'package:meter_app/utils/backend_util/collection_utils.dart';
import 'package:meter_app/utils/backend_util/dbutil.dart';
import 'package:meter_app/utils/backend_util/error_util.dart';
import 'package:meter_app/utils/backend_util/image_util.dart';
import 'package:meter_app/utils/backend_util/constant_util.dart';
import 'package:meter_app/utils/short_message_utils.dart';
import 'package:meter_app/view/bottom_nav/bottom_nav_main.dart';

import '../../../widget/success.dart';

class RequestServiceConsolationController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController applicantNameController = TextEditingController();
  final TextEditingController regionController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController neighborhoodController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

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
    return AuthUtil.validatePhoneNumber(fullPhoneNumber(), countryCode.value);
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
  RxString filePath = "".obs;
  RxString fileName = "".obs;
  Future<void> onClickContinue(GlobalKey<FormState> _formKey) async {
    try {
      loading.value = true;
      if (_formKey.currentState!.validate() &&
          isAllChecked &&
          filePath.value != "") {
        String fileUrl = await ImageUtil.uploadToDatabase(filePath.value);
        RequestServicesModel requestServicesModel = RequestServicesModel(
            id: DbUtil.getAutoUid()!,
            role: ConstantUtil.customer,
            userUID: DbUtil.getCurrentUid()!,
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
            activityType: ConstantUtil.consolation);
        await DbServices.addRequestService(requestServicesModel);
        Get.bottomSheet(
            isDismissible: false,
            enableDrag: false,
            CustomSuccessScreen(
              title: "Post Request",
              buttonTitle: "Done",
              desc:
                  "Your request has been posted. Click to show providers proposals",
              onDoneTap: () {
                clearAllFields();
                Get.offAll(const BottomNavMain());
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
      loading.value = false;
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
