// import 'package:get/get.dart';
// import 'package:local_auth/local_auth.dart';
// import 'package:meter_app/routes/routes_name.dart';
// import 'package:meter_app/utils/backend_util/dbutil.dart';
// import 'package:meter_app/utils/short_message_utils.dart';
// import 'package:meter_app/view/bottom_nav/bottom_nav_main.dart';
//
// class FingerAuthController extends GetxController {
//   final LocalAuthentication _localAuth = LocalAuthentication();
//   RxBool isAuthenticated = false.obs;
//   RxBool isLoading = false.obs;
//   RxBool isFingerprintAvailable = true.obs;
//
//   Future<void> checkFingerprintAvailability() async {
//     try {
//       isFingerprintAvailable.value = await _localAuth.canCheckBiometrics;
//       print("Is finger print $isFingerprintAvailable");
//     } catch (e) {
//       print('Error checking fingerprint availability: $e');
//       isFingerprintAvailable.value = false;
//     }
//   }
//
//   RxBool isContinueLoading = false.obs;
//   Future<void> onContinueClick() async {
//     try {
//       isContinueLoading.value = true;
//       if (isAuthenticated.value) {
//         await DbUtil.saveFingerData();
//         Get.offAllNamed(RoutesName.bottomNavMain);
//       } else {
//         ShortMessageUtils.showError("Please Scan Finger first");
//       }
//     } finally {
//       isContinueLoading.value = false;
//     }
//   }
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     checkFingerprintAvailability();
//   }
//
//   Future<void> authenticate() async {
//     try {
//       isLoading.value = true;
//       isAuthenticated.value = await _localAuth.authenticate(
//         localizedReason: 'Please authenticate to proceed',
//         options: const AuthenticationOptions(biometricOnly: true),
//       );
//       isLoading.value = false;
//     } catch (e) {
//       isLoading.value = false;
//       print('Authentication error: $e');
//     }
//   }
// }
