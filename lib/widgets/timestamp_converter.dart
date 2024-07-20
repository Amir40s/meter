import 'package:flutter/material.dart';
import 'package:meter/constant/res/app_color/app_color.dart';
class TimestampConverter extends StatelessWidget {
  final String timestampString;

  TimestampConverter({required this.timestampString});

  DateTime parseTimestamp(String timestampString) {
    return DateTime.parse(timestampString);
  }

  String convertTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

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

  @override
  Widget build(BuildContext context) {
    DateTime parsedTimestamp = parseTimestamp(timestampString);
    String formattedTimestamp = convertTimestamp(parsedTimestamp);

    return Text(
      formattedTimestamp,
      style: TextStyle(fontSize: 14,color: AppColor.primaryColor),
    );
  }
}