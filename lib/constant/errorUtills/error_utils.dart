import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

import '../prefUtils/message_utills.dart';

/// Utility class for handling errors across the application.
class ErrorUtil {
  /// Handles common API errors by displaying appropriate error messages to the user.
  ///
  /// This method catches and handles [TimeoutException], [SocketException], and
  /// [FirebaseException]. For all other error types, a generic error message is shown.
  ///

  static Future<void> handleDatabaseErrors(dynamic error) async {
    if (error is TimeoutException) {
      ShortMessageUtils.showError("Request timed out. Please try again.");
    } else if (error is SocketException) {
      ShortMessageUtils.showError(
          "Network error. Please check your internet connection.");
    } else if (error is FirebaseException) {
      // Handle Firebase-specific errors
      _handleFirebaseError(error);
    } else {
      print("Unexpected Error---- $error");
      ShortMessageUtils.showError(
          "An unexpected error occurred. Please try again later.");
    }
  }

  /// Handles [FirebaseAuth] Specific errors.

  static Future<void> handleOtpErrors(dynamic error) async {
    if (error is TimeoutException) {
      ShortMessageUtils.showError("Request timed out. Please try again.");
    } else if (error is SocketException) {
      ShortMessageUtils.showError(
          "Network error. Please check your internet connection.");
    } else if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-verification-code':
          ShortMessageUtils.showError('Invalid OTP entered');
          break;
        case 'quota-exceeded':
          ShortMessageUtils.showError('Quota exceeded. Please try again later');
          break;
        case 'too-many-requests':
          ShortMessageUtils.showError(
              'Too many requests. Please try again later');
          break;
        case 'session-expired':
          ShortMessageUtils.showError('Session expired. Please try again');
          break;
        default:
          ShortMessageUtils.showError('Verification failed: ${error.message}');
      }
    } else {
      print("Unexpected Error: $error");
      ShortMessageUtils.showError(
          "An unexpected error occurred. Please try again later.");
    }
  }

  /// Handles [FirebaseAuth] Specific errors such as [OtpFailures].

  static Future<void> handleOtpFailure(FirebaseAuthException e) async {
    if (e.code == 'invalid-phone-number') {
      ShortMessageUtils.showError("Invalid phone number entered");
    } else if (e.code == 'too-many-requests') {
      ShortMessageUtils.showError("Too many requests. Please try again later");
    } else {
      ShortMessageUtils.showError('Verification failed: ${e.message}');
    }
  }

  /// Handles Firebase-specific errors.
  static void _handleFirebaseError(FirebaseException error) {
    // Customize the message based on error codes
    String errorMessage = "An error occurred. Please try again later.";
    switch (error.code) {
      case "permission-denied":
        errorMessage = "You don't have permission to access this resource.";
        break;
      case "not-found":
        errorMessage = "The requested document was not found.";
        break;
      case "quota-exceeded":
        errorMessage = "You have exceeded your quota.";
        break;
    // Add more cases as needed
    }

    ShortMessageUtils.showError(errorMessage);
    print(
        "FirebaseException Code---- ${error.code}, Message---- ${error.message}");
  }
}
