import 'package:get/get.dart';
import 'package:meter/constant/routes/routes_name.dart';
import 'package:meter/screens/bottomNav/bottom_nav_screen.dart';

import '../../screens/splash/splash_screen.dart';

class Routes {
  static final routes = [
    GetPage(
      name: RoutesName.splashScreen,
      page: () => const SplashScreen(),
    ),
    // GetPage(
    //   name: RoutesName.mainAuthScreen,
    //   page: () =>  MainAuth(),
    // ),
    // GetPage(
    //   name: RoutesName.verificationScreen,
    //   page: () => const VerificationScreen(),
    // ),
    // GetPage(
    //   name: RoutesName.customerGeneralInfoScreen,
    //   page: () => const CustomerGeneralInfo(),
    // ),
    // GetPage(
    //   name: RoutesName.sellerFaceAuth,
    //   page: () => const SellerFaceAuth(),
    // ),
    GetPage(
      name: RoutesName.bottomNavMain,
      page: () => const BottomNav(),
    ),
    // GetPage(
    //   name: RoutesName.onBoard,
    //   page: () => const (),
    // ),
    // GetPage(
    //   name: RoutesName.publishFirstDevice,
    //   page: () => const PublishFirstDevice(),
    // ),
  ];
}
