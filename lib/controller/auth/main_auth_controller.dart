import 'package:get/get.dart';

import '../../constant.dart';

class MainAuthController extends GetxController {

  RxBool selectedLogin = true.obs;
  var isChecked = false.obs;
  RxString selectedRole = seller.obs;

  void changeActive(bool newValue) {
    selectedLogin.value = newValue;
  }

  void switchToNewRole(String newRole) {
    selectedRole.value = newRole;
  }

  void toggleCheckbox(bool? value) {
    isChecked.value = value ?? false;
  }
}
