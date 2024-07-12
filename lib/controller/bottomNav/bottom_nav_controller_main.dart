import 'package:get/get.dart';
import 'package:meter/services/user/user_services.dart';

class BottomNavController extends GetxController {
  RxString currentRole = "".obs;
  Future<void> getCurrentRole() async {
    // currentRole.value = PrefUtil.getString(PrefUtil.role);
    currentRole.value = await UserServices.getRoleByUid();
  }

  RxInt currentIndex = 0.obs;

  void onIndexChange(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentRole();
  }
}
