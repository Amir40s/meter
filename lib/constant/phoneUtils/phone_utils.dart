import 'dart:developer';
import 'package:dlibphonenumber/dlibphonenumber.dart';
import '../CollectionUtils/collection_utils.dart';
import '../errorUtills/error_utils.dart';
import '../prefUtils/pref_utils.dart';

class PhoneUtil {

  static bool validatePhoneNumber(String fullPhoneNumber, String isoCode) {
    try {
      PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
      PhoneNumber phoneNumber = phoneUtil.parse(fullPhoneNumber, isoCode);
      bool isValid = phoneUtil.isValidNumber(phoneNumber);
      return isValid;
    } catch (e) {
      log("Failed to validate phone number: $e");
      return false;
    }
  }

  static Future<bool> checkPhoneNumberExist({
    required String phoneNumber,
  }) async {
    try {
      final querySnapshot = await CollectionUtils.userCollection
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final userDoc = querySnapshot.docs.first;
        final userUID = userDoc.id;

        log("PhoneNumber is $phoneNumber and UID is $userUID");
        return true;
      } else {
        return false;
      }
    } catch (error) {
      ErrorUtil.handleDatabaseErrors(error);
      return false;
    }
  }

  static Future<Map<String, dynamic>> checkPhoneNumberExists({
    required String phoneNumber,
  }) async {
    try {
      final querySnapshot = await CollectionUtils.userCollection
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final userDoc = querySnapshot.docs.first;
        final userUID = userDoc.id;
        log("PhoneNumber is $phoneNumber, UID is $userUID");
        return {'exists': true, 'uid': userUID};
      } else {
        return {'exists': false};
      }
    } catch (error) {
      ErrorUtil.handleDatabaseErrors(error);
      return {'exists': false};
    }
  }

  static Future<bool> checkPhoneNumberAndGetUserId({
    required String phoneNumber,
  }) async {
    try {
      final querySnapshot = await CollectionUtils.userCollection
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        log("PhoneNumber is $phoneNumber");
        // Extract and print the username
        final userData =
        querySnapshot.docs.first.data() as Map<String, dynamic>;
        final userId = userData['userId'];
        log("User Id is $userId");

        PrefUtil.setString(PrefUtil.userId, userId);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      ErrorUtil.handleDatabaseErrors(error);
      return false;
    }
  }

  static String formatPhoneNumber(String phoneNumber) {

    String formattedNumber = '';

    if (phoneNumber.startsWith('+')) {

      String countryCode = phoneNumber.substring(
          0, phoneNumber.indexOf(' ') != -1 ? phoneNumber.indexOf(' ') : 3);
      String number =
      phoneNumber.substring(countryCode.length).replaceAll(' ', '');

      // Format the number part with masking

      for (int i = 0; i < number.length; i++) {
        if (i < 3 || i >= number.length - 4) {
          formattedNumber += number[i];
        } else if (i == 3) {
          formattedNumber += ' **** ';
        } else {
          formattedNumber += '*';
        }
      }

      return '$countryCode $formattedNumber';
    } else {
      // Handle phone numbers without a '+'
      String number = phoneNumber.replaceAll(' ', '');

      // Format the number part with masking
      String formattedNumber = '';
      for (int i = 0; i < number.length; i++) {
        if (i < 2 || i >= number.length - 4) {
          formattedNumber += number[i];
        } else if (i == 2) {
          formattedNumber += ' **** ';
        } else {
          formattedNumber += '*';
        }
      }

      return formattedNumber;
    }
  }
}
