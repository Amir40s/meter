import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProposalController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  List helpList = ["New", "Active", "Completed"];
  RxInt selectedIndex = 0.obs;

  void onChangeSelectedIndex(int newIndex) {
    selectedIndex.value = newIndex;
  }
}
