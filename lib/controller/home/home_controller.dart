import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/services/user/user_services.dart';

import '../../constant/res/app_images/app_images.dart';

class HomeController extends GetxController {
  RxString currentRole = "".obs;
  Future<void> getCurrentRole() async {
    // currentRole.value = PrefUtil.getString(PrefUtil.role);
    currentRole.value = await UserServices.getRoleByUid();
  }

  final TextEditingController searchController = TextEditingController();
  List imaPath = [
    AppImage.surveyReport,
    AppImage.completionCertificate,
    AppImage.accupancyCertificate,
    AppImage.designWork
  ];

  List title = [
    "Survey Reports",
    "Building Completion Certificate",
    "Occupancy Certificate",
    "Design Work"
  ];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentRole();
  }
}
