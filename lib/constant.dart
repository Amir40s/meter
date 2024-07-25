import 'dart:developer';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

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

FirebaseFirestore firestore = FirebaseFirestore.instance;


const String mapAPIKEY = "AIzaSyCog7RsE7QqPGoGhJePgBaaXqNbuO8fDAE";

const String messageUserNameKey = "metersms";
const String messageApiKey = "3AE720DBA7FD7AC83952CE271A0C6633";
const String messageSenderNameKey = "MeterApp";

const String BASE_URL = "https://www.msegat.com/gw";
const String sendOtpApiRequest = "$BASE_URL/sendOTPCode.php";
const String verifyOtpApiRequest = "$BASE_URL/verifyOTPCode.php";

String? getCurrentUid() {
  String userId = PrefUtil.getString(PrefUtil.userId);
  return userId;
}

void setUserUID(String value){
  PrefUtil.setString(PrefUtil.userId, value);
}

String? getAutoUid() {
  log("ID is ${CollectionUtils.userCollection.doc().id}");
  return CollectionUtils.userCollection.doc().id;
}

void changeLanguage(var languageCode, var countryCode) {
  var locale = Locale(languageCode, countryCode);
  Get.updateLocale(locale);
}

String convertTimestamp(String timestampString) {
  DateTime parsedTimestamp = parseTimestamp(timestampString);
  final now = DateTime.now();
  final difference = now.difference(parsedTimestamp);

  if (difference.inMinutes < 60) {
    return '${difference.inMinutes}m';
  } else if (difference.inHours < 24) {
    return '${difference.inHours}h';
  } else if (difference.inDays < 30) {
    return '${difference.inDays}d';
  } else if (difference.inDays < 365) {
    final months = difference.inDays ~/ 30;
    return '${months}mm';
  } else {
    final years = difference.inDays ~/ 365;
    return '${years}y';
  }
}

DateTime parseTimestamp(String timestampString) {
  return DateTime.parse(timestampString);
}

String formatTimestamp(String timestamp) {
  // Clean the timestamp string by removing any non-breaking spaces or special characters
  timestamp = timestamp.replaceAll('\u200E', '');

  // Define the input format of the timestamp string
  DateFormat inputFormat = DateFormat("MMMM d, y 'at' h:mm:ss a 'UTC'x");

  // Parse the input timestamp string to a DateTime object
  DateTime dateTime;
  try {
    dateTime = inputFormat.parse(timestamp, true).toLocal();
  } catch (e) {
    return 'Invalid date format';
  }

  // Define the desired output format
  DateFormat outputFormat = DateFormat('HH:mm dd/MM/yyyy');

  // Format the DateTime object to the desired format
  return outputFormat.format(dateTime);
}

String getGreeting() {
  DateTime now = DateTime.now();
  int hour = now.hour;

  if (hour >= 6 && hour < 12) {
    return "Good Morning".tr ;
  } else if (hour >= 12 && hour < 18) {
    return "Good Afternoon".tr;
  } else {
    return "Good Evening".tr;
  }
}
