import 'package:intl/intl.dart';

class DateTimeUtil {
  static String reformatDate(String dateString) {
    // Parse the original date string
    DateTime parsedDate = DateTime.parse(dateString);

    // Format the date into the desired format
    String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

    return formattedDate;
  }
}
