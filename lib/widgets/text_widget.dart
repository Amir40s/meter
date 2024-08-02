import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/res/app_color/app_color.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final bool showUnderline;
  final Color underLineColor;
  final TextAlign textAlign;
  final TextOverflow? textOverflow;
  const TextWidget(
      {super.key,
      required this.title,
      this.textColor = AppColor.semiTransparentDarkGrey,
      this.fontSize = 14,
      this.fontWeight = FontWeight.w500,
      this.showUnderline = false,
      this.textAlign = TextAlign.center,
      this.underLineColor = AppColor.primaryColor,
      this.textOverflow});

  @override
  Widget build(BuildContext context) {
    return Text(
      // minFontSize: 5,
      // maxFontSize: fontSize,
      title.tr,
      textAlign: textAlign,
      overflow: textOverflow,
      softWrap: true,
      style: GoogleFonts.poppins(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          decorationColor: underLineColor,
          decoration:
              showUnderline ? TextDecoration.underline : TextDecoration.none),
    );
  }
}
