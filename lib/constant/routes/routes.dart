import 'package:get/get.dart';
import 'package:meter/constant/routes/routes_name.dart';
import 'package:meter/screens/bottomNav/bottom_nav_screen.dart';
import 'package:meter/screens/cServices/services_screen.dart';
import 'package:meter/screens/login/login_screen.dart';
import 'package:meter/screens/mainLoginSignup/main_login_signup_screen.dart';
import 'package:meter/screens/onboard/onboard_screen.dart';
import 'package:meter/screens/onboard/onboard_welcome_screen.dart';
import 'package:meter/screens/otpVerificatio/otp_verification_screen.dart';
import 'package:meter/screens/requestServices/request_services_screen.dart';
import 'package:meter/screens/signup/signup_screen.dart';

import '../../screens/splash/splash_screen.dart';

class Routes {
  static final routes = [
    GetPage(
      name: RoutesName.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RoutesName.loginScreen,
      page: () =>  LoginScreen(),
    ),
    GetPage(
      name: RoutesName.signUpScreen,
      page: () =>  SignupScreen(),
    ),
    GetPage(
      name: RoutesName.requestServicesScreen,
      page: () =>  RequestServicesScreen(),
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
      page: () =>  MainLoginSignupScreen(),
    ),

    GetPage(
      name: RoutesName.otpVerificationScreen,
      page: () =>  OtpVerificationScreen(),
    ),
    // GetPage(
    //   name: RoutesName.publishFirstDevice,
    //   page: () => const PublishFirstDevice(),
    // ),
  ];
}
