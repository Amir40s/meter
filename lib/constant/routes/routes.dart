import 'package:get/get.dart';
import 'package:meter/constant/routes/routes_name.dart';
import 'package:meter/screens/bottomNav/bottom_nav_screen.dart';
import 'package:meter/screens/cServices/services_screen.dart';
import 'package:meter/screens/login/login_screen.dart';
import 'package:meter/screens/mainLoginSignup/main_login_signup_screen.dart';
import 'package:meter/screens/onboard/onboard_screen.dart';
import 'package:meter/screens/onboard/onboard_welcome_screen.dart';
import 'package:meter/screens/otpVerificatio/otp_verification_screen.dart';
import 'package:meter/screens/payment/payment_screen.dart';
import 'package:meter/screens/requestServices/request_services_screen.dart';
import 'package:meter/screens/signup/face.dart';
import 'package:meter/screens/signup/finger.dart';
import 'package:meter/screens/signup/seller/general_info_1.dart';
import 'package:meter/screens/signup/seller/general_info_2.dart';
import 'package:meter/screens/signup/signup_screen.dart';

import '../../screens/signup/customer/customer_general_info.dart';
import '../../screens/signup/provider/provider_general_info_1.dart';
import '../../screens/signup/provider/provider_general_info_2.dart';
import '../../screens/signup/seller/general_info.dart';
import '../../screens/splash/splash_screen.dart';

class Routes {
  static final routes = [
    GetPage(
      name: RoutesName.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RoutesName.loginScreen,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: RoutesName.signUpScreen,
      page: () => const SignupScreen(),
    ),
    GetPage(
      name: RoutesName.requestServicesScreen,
      page: () => const RequestServicesScreen(),
    ),
    GetPage(
      name: RoutesName.customerGeneralInfoScreen,
      page: () => const CustomerGeneralInfo(),
    ),
    GetPage(
      name: RoutesName.bottomNavMain,
      page: () => const BottomNav(),
    ),
    GetPage(
      name: RoutesName.onBoardScreen,
      page: () => const OnboardScreen(),
    ),
    GetPage(
      name: RoutesName.onBoardWelcomeScreen,
      page: () => const OnboardWelcomeScreen(),
    ),
    GetPage(
      name: RoutesName.mainLoginSignupScreen,
      page: () => MainLoginSignupScreen(),
    ),

    GetPage(
      name: RoutesName.otpVerificationScreen,
      page: () => const OtpVerificationScreen(),
    ),
    GetPage(
      name: RoutesName.faceAuth,
      page: () => FaceAuth(),
    ),
    GetPage(
      name: RoutesName.sellerGeneralInfo,
      page: () => const SellerGeneralInfo(),
    ),
    GetPage(
      name: RoutesName.fingerAuth,
      page: () => FingerAuth(),
    ),
    GetPage(
      name: RoutesName.sellerFirstGeneralInfo,
      page: () => const SellerFirstGeneralInfo(),
    ),
    GetPage(
      name: RoutesName.sellerSecondGeneralInfo,
      page: () => const SellerSecondGeneralInfo(),
    ),
    GetPage(
      name: RoutesName.sellerSecondGeneralInfo,
      page: () => const OnboardScreen(),
    ),
    GetPage(
      name: RoutesName.providerFirstGeneralInfo,
      page: () => const ProviderFirstGeneralInfo(),
    ),
    GetPage(
      name: RoutesName.providerSecondGeneralInfo,
      page: () => const ProviderSecondGeneralInfo(),
    ),
    GetPage(
      name: RoutesName.paymentScreen,
      page: () => PaymentScreen(),
    ),
    // GetPage(
    //   name: RoutesName.publishFirstDevice,
    //   page: () => const PublishFirstDevice(),
    // ),
  ];
}
