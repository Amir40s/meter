import 'package:get/get.dart';

/// A utility class for validation functions commonly used in form fields.
class ValidationUtils {
  /// Validates if the length of the input value is within a specified range.
  ///
  /// Returns a validation error message if the length is not within the range.
  static String? Function(String?) validateLengthRange(
      String name, int minLength,
      {int? maxLength}) {
    return (String? value) {
      if (GetUtils.isNullOrBlank(value)!) {
        return "${name.tr} ${"is required".tr}";
      }
      if (!GetUtils.isLengthGreaterThan(value!, minLength)) {
        return "${"Length must be greater than".tr} $minLength";
      }
      if (maxLength != null && GetUtils.isLengthGreaterThan(value, maxLength)) {
        return "${"Length must be less than".tr} $maxLength";
      }
      // Return null when the value is valid
      return null;
    };
  }

  /// Validates if the input value is a valid email address.
  ///
  /// Returns a validation error message if the value is not a valid email address.
  static String? validateEmail(String? value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return "Email is required".tr;
    }
    if (!GetUtils.isEmail(value!)) {
      return "Email must be valid".tr;
    }
    // Return null when the value is valid
    return null;
  }

  /// Validates if the input value is not null or blank.
  ///
  /// Returns a validation error message if the value is null or blank.
  static String? Function(String?) validateRequired(String name) {
    return (String? value) {
      if (GetUtils.isNullOrBlank(value)!) {
        return "${name.tr} ${"is required".tr}";
      }
      // Return null when the value is valid
      return null;
    };
  }
}
