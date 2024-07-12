import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestFormController extends GetxController {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController taxController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  var selectedOption =
      'Consolation'.obs; // Observable to track the selected option

  void selectOption(String option) {
    selectedOption.value = option;
  }

  var isAgreeTermsChecked = false.obs;

  void toggleAgreeTerms(bool? value) {
    isAgreeTermsChecked.value = value ?? false;
  }
}
