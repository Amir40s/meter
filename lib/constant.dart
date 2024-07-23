import 'dart:developer';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'constant/CollectionUtils/collection_utils.dart';
import 'constant/prefUtils/pref_utils.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constant/res/app_color/app_color.dart';

class AppTextStyle {
  static TextStyle dark14 = GoogleFonts.poppins(
    color: AppColor.semiTransparentDarkGrey,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );
  static TextStyle dark20 = GoogleFonts.poppins(
    color: AppColor.semiDarkGrey,
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
  );
}

const String seller = "Seller";
const String customer = "Customer";
const String provider = "Provider";
const String consolation = "Consolation";
const String requestService = "Request Service";
const String engineeringJob = "Engineering Job";

///////////////////API////////////////////

const String mapAPIKEY = "AIzaSyCog7RsE7QqPGoGhJePgBaaXqNbuO8fDAE";

const String messageUserNameKey = "metersms";
const String messageApiKey = "3AE720DBA7FD7AC83952CE271A0C6633";
const String messageSenderNameKey = "MeterApp";

const String BASE_URL = "https://www.msegat.com/gw";
const String sendOtpApiRequest = "$BASE_URL/sendOTPCode.php";
const String verifyOtpApiRequest = "$BASE_URL/verifyOTPCode.php";

String? getCurrentUid() {
  PrefUtil.setString(PrefUtil.userId, "85aqKUgX1OW1dhHC3DCK");
  String userId = PrefUtil.getString(PrefUtil.userId);
  return userId;
}

String? getAutoUid() {
  log("ID is ${CollectionUtils.userCollection.doc().id}");
  return CollectionUtils.userCollection.doc().id;
}

void changeLanguage(var languageCode, var countryCode) {
  var locale = Locale(languageCode, countryCode);
  Get.updateLocale(locale);
}

String getGreeting() {
  DateTime now = DateTime.now();
  int hour = now.hour;

  if (hour >= 6 && hour < 12) {
    return "Good Morning";
  } else if (hour >= 12 && hour < 18) {
    return "Good Afternoon";
  } else {
    return "Good Evening";
  }
}
