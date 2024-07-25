import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ChatSearchController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  var searchQuery = ''.obs;

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }
}