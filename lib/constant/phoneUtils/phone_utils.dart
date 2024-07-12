// import 'dart:developer';
// import 'package:dlibphonenumber/dlibphonenumber.dart';
// import 'package:meter/constant/DB/collection_utils.dart';
// import '../errorUtills/error_utils.dart';
// import '../prefUtils/pref_utils.dart';
//
// class PhoneUtil {
//
//   static bool validatePhoneNumber(String fullPhoneNumber, String isoCode) {
//     try {
//       PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
//       PhoneNumber phoneNumber = phoneUtil.parse(fullPhoneNumber, isoCode);
//       bool isValid = phoneUtil.isValidNumber(phoneNumber);
//       return isValid;
//     } catch (e) {
//       log("Failed to validate phone number: $e");
//       return false;
//     }
//   }
//
//   static Future<bool> checkPhoneNumberExist({
//     required String phoneNumber,
//   }) async {
//     try {
//       final querySnapshot = await CollectionUtils.userCollection
//           .where('phoneNumber', isEqualTo: phoneNumber)
//           .get();
//       if (querySnapshot.docs.isNotEmpty) {
//         log("PhoneNumber is $phoneNumber");
//         return true;
//       } else {
//         return false;
//       }
//     } catch (error) {
//       ErrorUtil.handleDatabaseErrors(error);
//       return false;
//     }
//   }
//
//   static Future<bool> checkPhoneNumberAndGetUserId({
//     required String phoneNumber,
//   }) async {
//     try {
//       final querySnapshot = await CollectionUtils.userCollection
//           .where('phoneNumber', isEqualTo: phoneNumber)
//           .get();
//
//       if (querySnapshot.docs.isNotEmpty) {
//         log("PhoneNumber is $phoneNumber");
//         // Extract and print the username
//         final userData =
//         querySnapshot.docs.first.data() as Map<String, dynamic>;
//         final userId = userData['userId'];
//         log("User Id is $userId");
//
//         PrefUtil.setString(PrefUtil.userId, userId);
//         return true;
//       } else {
//         return false;
//       }
//     } catch (error) {
//       ErrorUtil.handleDatabaseErrors(error);
//       return false;
//     }
//   }
// }
