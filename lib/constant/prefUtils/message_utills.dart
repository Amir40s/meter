import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/text_widget.dart';
import '../res/app_color/app_color.dart';

/// A utility class for displaying short messages [snackbars] with success or error feedback.
class ShortMessageUtils {
  /// Displays a [success] message [snackbar].

  static void showSuccess(String message) {
    Get.snackbar(
      '', // Title is empty to use only message
      message,
      icon: const Icon(Icons.check_circle_outline, color: AppColor.whiteColor),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColor.primaryColor,
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      animationDuration: const Duration(milliseconds: 800),
      snackStyle: SnackStyle.FLOATING,
      boxShadows: [
        const BoxShadow(
          color: Colors.black45,
          offset: Offset(0, 2),
          blurRadius: 6,
        ),
      ],
      titleText: const TextWidget(
        textAlign: TextAlign.start,
        title: "Success!",
        fontSize: 20,
        textColor: AppColor.whiteColor,
      ),
      messageText: TextWidget(
        textAlign: TextAlign.start,
        title: message,
        fontSize: 16,
        textColor: AppColor.whiteColor,
      ),
    );
  }

  /// Displays an [error] message [snackbar].

  static void showError(String message) {
    Get.snackbar(
      '', // Title is empty to use only message
      message,
      icon: const Icon(Icons.error_outline, color: AppColor.whiteColor),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red[600],
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: AppColor.whiteColor,
      duration: const Duration(seconds: 4),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      animationDuration: const Duration(milliseconds: 800),
      snackStyle: SnackStyle.FLOATING,
      boxShadows: [
        const BoxShadow(
          color: Colors.black45,
          offset: Offset(0, 2),
          blurRadius: 6,
        ),
      ],
      titleText: const TextWidget(
        textAlign: TextAlign.left,
        title: "Error",
        textColor: AppColor.whiteColor,
        fontSize: 20,
      ),
      messageText: TextWidget(
        textAlign: TextAlign.left,
        title: message,
        fontSize: 16,
        textColor: AppColor.whiteColor,
      ),
    );
  }
}
