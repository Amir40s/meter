import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/services/request/request_services.dart';
import '../../bottomSheet/success/success_bottom_sheet.dart';
import '../../constant.dart';
import '../../constant/CollectionUtils/collection_utils.dart';
import '../../constant/errorUtills/error_utils.dart';
import '../../constant/errorUtills/image_utils.dart';
import '../../constant/prefUtils/message_utills.dart';
import '../../constant/routes/routes_name.dart';
import '../../model/devices/devices_model.dart';

class PublishDeviceController extends GetxController {
  final TextEditingController deviceNameController = TextEditingController();
  final TextEditingController deviceCategoryController =
      TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController manufacturingYearController =
      TextEditingController();
  final TextEditingController manufacturerController = TextEditingController();
  final TextEditingController industryController = TextEditingController();
  final TextEditingController devicePriceController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  RxList deviceCategory = [].obs;

  RxString imagePath = "".obs;

  RxString imageUrl = "".obs;

  Future<void> editInitialization(
      bool isUpdate, DeviceModel? deviceModel) async {
    if (deviceModel != null) {
      selectedOption.value = deviceModel.deviceType;
      deviceNameController.text = deviceModel.deviceName;
      deviceCategoryController.text = deviceModel.deviceCategory;
      modelController.text = deviceModel.deviceModel;
      manufacturingYearController.text = deviceModel.deviceManufacturingYear;
      devicePriceController.text = deviceModel.devicePrice;
      detailsController.text = deviceModel.deviceDetails;
      imageUrl.value = deviceModel.deviceImage;
    }
  }

  Future<void> updateDevice(String deviceId) async {
    try {
      isLoading.value = true;

      if (imagePath.value.isNotEmpty) {
        imageUrl.value = await ImageUtil.uploadToDatabase(imagePath.value);
      }

      Map<String, dynamic> updatedDeviceData = {
        "deviceType": selectedOption.value,
        "deviceName": deviceNameController.text,
        "deviceCategory": deviceCategoryController.text,
        "deviceModel": modelController.text,
        "deviceManufacturingYear": manufacturingYearController.text,
        "devicePrice": devicePriceController.text,
        "deviceDetails": detailsController.text,
        "deviceImage": imageUrl.value,
      };

      await RequestServices.updateDevice(deviceId, updatedDeviceData);
      Get.bottomSheet(
          enableDrag: false,
          isDismissible: false,
          SuccessBottomSheet(
            title: "Update Device",
            buttonTitle: "Done",
            onDoneTap: () {
              Get.offAllNamed(RoutesName.bottomNavMain);
            },
            desc:
                "Your device has been updated. Click to show providers proposals",
          ));
    } catch (e) {
      ErrorUtil.handleDatabaseErrors(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchDeviceCategory() async {
    try {
      QuerySnapshot querySnapshot =
          await CollectionUtils.deviceCategoryCollection.get();

      deviceCategory.clear();

      for (var doc in querySnapshot.docs) {
        deviceCategory.add(doc['name']);
      }
      log("Neighborhood $deviceCategory");
    } catch (e) {
      print('Error fetching neighborhoods: $e');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchDeviceCategory();
  }

  void onChangeDropDown(String newValue) {
    deviceCategoryController.text = newValue;
  }

  void clearAllFields() {
    deviceNameController.clear();
    deviceCategoryController.clear();
    modelController.clear();
    manufacturingYearController.clear();
    devicePriceController.clear();
    detailsController.clear();
  }

  var selectedOption = 'Buy'.obs;

  void selectOption(String option) {
    selectedOption.value = option;
  }

  var isSellerAgreeTermsChecked = false.obs;
  var isSellerAccurateInfoChecked = false.obs;
  var isSellerPayDuesChecked = false.obs;

  void toggleSellerAgreeTerms(bool? value) {
    isSellerAgreeTermsChecked.value = value ?? false;
  }

  void toggleSellerAccurateInfo(bool? value) {
    isSellerAccurateInfoChecked.value = value ?? false;
  }

  void toggleSellerPayDues(bool? value) {
    isSellerPayDuesChecked.value = value ?? false;
  }

  bool get areAllSellerChecked =>
      isSellerAgreeTermsChecked.value &&
      isSellerAccurateInfoChecked.value &&
      isSellerPayDuesChecked.value;

  RxBool isLoading = false.obs;
  Future<void> publishDeviceClick(GlobalKey<FormState> _formKey) async {
    try {
      isLoading.value = true;
      if (_formKey.currentState!.validate() &&
          imagePath.value != "" &&
          areAllSellerChecked) {
        String imageUrl = await ImageUtil.uploadToDatabase(imagePath.value);
        DeviceModel deviceModel = DeviceModel(
          id: getAutoUid()!,
          deviceType: selectedOption.value,
          deviceName: deviceNameController.text,
          deviceCategory: deviceCategoryController.text,
          userUID: getCurrentUid()!,
          deviceModel: modelController.text,
          deviceManufacturingYear: manufacturingYearController.text,
          devicePrice: devicePriceController.text,
          deviceDetails: detailsController.text,
          deviceImage: imageUrl,
          rating: 0.0,
        );

        await RequestServices.addDevice(deviceModel);
        log("Device added successfully");
        Get.bottomSheet(
            enableDrag: false,
            isDismissible: false,
            SuccessBottomSheet(
              title: "Post Device",
              buttonTitle: "Done",
              onDoneTap: () {
                Get.offAllNamed(RoutesName.bottomNavMain);
              },
              desc:
                  "Your device has been posted. Click to show providers proposals",
            ));
      } else {
        if (imagePath.value != "") {
          ShortMessageUtils.showError("Please fill all fields");
        } else if (!areAllSellerChecked) {
          ShortMessageUtils.showError("Please accept all policies");
        } else {
          ShortMessageUtils.showError("Please pick image");
        }
      }
    } catch (e) {
      ErrorUtil.handleDatabaseErrors(e);
    } finally {
      isLoading.value = false;
    }
  }
}
