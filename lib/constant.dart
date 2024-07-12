
import 'dart:developer';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'constant/DB/collection_utils.dart';
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



String? getCurrentUid() {
  String userId = PrefUtil.getString(PrefUtil.userId);
  log("User  Id is $userId");
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
