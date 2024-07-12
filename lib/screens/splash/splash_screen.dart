import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../constant.dart';
import '../../constant/prefUtils/pref_utils.dart';
import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../constant/routes/routes_name.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Timer(const Duration(seconds: 4),(){

      bool? isEnglish = PrefUtil.getBool(PrefUtil.language) ?? true;
      if(isEnglish){
        changeLanguage("en", "US");
      }else{
       changeLanguage("ar", "Ar");
      }
      navigate();
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: Center(
          child: Container(
              width: Get.width,
              height: Get.height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    AppImage.meter,
                    width: Get.width / 1.5,
                  ),
                  Positioned(
                    bottom: Get.width * 0.2,
                    child: Lottie.asset(
                      AppImage.loadingAnimation,
                      width: Get.width / 2.6,
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
  void navigate() {
    final auth = getCurrentUid();
    log("Auth is----> $auth");

    if (auth != "" && auth != null) {
      Get.offAllNamed(RoutesName.bottomNavMain);
    } else {
      Get.offAllNamed(RoutesName.onBoardScreen);
    }
  }
}
