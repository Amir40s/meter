import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DeviceController extends GetxController {
  TextEditingController searchController = TextEditingController();
  RxString deviceSearch = "".obs;
  void onChangeSearch(String newValue) {
    deviceSearch.value = newValue;
  }
}
