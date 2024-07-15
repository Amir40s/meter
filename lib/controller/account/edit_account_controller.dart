import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:meter/constant/CollectionUtils/collection_utils.dart';
import 'package:meter/constant/errorUtills/error_utils.dart';
import 'package:meter/constant/errorUtills/image_utils.dart';
import 'package:meter/constant/prefUtils/message_utills.dart';
import 'package:meter/controller/account/profile_controller.dart';
import 'package:meter/model/user/user_model.dart';

class EditAccountController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController neighborhoodController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  RxString id = "".obs;
  RxBool isLoading = false.obs;

  RxString imagePath = "".obs;
  RxString imageUrl = "".obs;
  RxString flagUri = "flags/sa.png".obs;
  RxString countryCode = "+966".obs;
  RxString countryShortCode = "SA".obs;

  void clearAllFields() {
    nameController.clear();
    emailController.clear();
    cityController.clear();
    neighborhoodController.clear();
  }

  void onChangeFlag(String changedUri, String code, String country) {
    flagUri.value = changedUri; // Update the flag image URI.
    countryCode.value = code; // Update the country code.
    countryShortCode.value = country; // Update the country's short code.
    print("$code $country");
  }

  void fetchAllValue() {
    final controller = Get.find<ProfileController>();
    UserModel userModel = controller.user.value;
    imageUrl.value = userModel.profilePicture;
    emailController.text = userModel.email;
    nameController.text = userModel.ownerName;
    cityController.text = userModel.city;
    neighborhoodController.text = userModel.neighborhood;
    id.value = userModel.userId;
  }

  Future<void> updateProfile(GlobalKey<FormState> formKey) async {
    try {
      isLoading.value = true;
      if (formKey.currentState!.validate()) {
        final controller = Get.find<ProfileController>();

        if (imagePath.value != "") {
          imageUrl.value = await ImageUtil.uploadToDatabase(imagePath.value);
        }

        final fieldsToUpdate = {
          "profilePicture": imageUrl.value,
          "neighborhood": neighborhoodController.text,
          "ownerName": nameController.text,
          "email": emailController.text,
          "city": cityController.text
        };
        await CollectionUtils.userCollection
            .doc(id.value)
            .update(fieldsToUpdate);
        await controller.fetchUserData();
        imagePath.value = "";
        isLoading.value = false;
        Get.back();
      } else {
        ShortMessageUtils.showError("Please fill all fields");
      }
    } catch (e) {
      isLoading.value = false;
      ErrorUtil.handleDatabaseErrors(e);
    }
  }
}
