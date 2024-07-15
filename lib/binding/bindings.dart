import 'package:get/get.dart';
import 'package:meter/controller/account/profile_controller.dart';
import 'package:meter/controller/bottomNav/bottom_nav_controller_main.dart';

import '../controller/account/edit_account_controller.dart';
import '../controller/auth/main_auth_controller.dart';
import '../controller/home/home_controller.dart';
import '../controller/onboard/onboard_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true);
    Get.put(EditAccountController(), permanent: true);
    Get.put(OnBoardController(), permanent: true);
    Get.put(HomeController(), permanent: true);
    Get.put(MainAuthController(),
        permanent: true); // Keeps the controller in memory
  }
}
