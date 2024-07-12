import 'package:flutter/material.dart';
import 'package:meter/widgets/text_widget.dart';

import '../constant/res/app_color/app_color.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final VoidCallback onTap;
  final Color? textColor;
  final double padding;
  const CustomButton(
      {super.key,
        required this.title,
        required this.onTap,
        this.backgroundColor,
        this.textColor,
        this.padding = 15});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  color: backgroundColor ?? AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                    child: TextWidget(
                      title: title,
                      fontSize: 16,
                      textColor: textColor ?? Colors.white,
                    )),
              ),
            ))
      ],
    );
  }
}

class MyCustomButton extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? borderSideColor;
  final String? iconPath;
  final double padding;
  final double fontSize;
  const MyCustomButton(
      {super.key,
        required this.title,
        required this.onTap,
        this.backgroundColor,
        this.textColor,
        this.borderSideColor,
        this.iconPath,
        this.padding = 15,
        this.fontSize = 16});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                    color: backgroundColor ?? AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: borderSideColor ?? Colors.transparent, width: 2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    iconPath != null
                        ? Image.asset(
                      iconPath!,
                      width: 24,
                    )
                        : Container(),
                    iconPath != null
                        ? const SizedBox(
                      width: 10,
                    )
                        : Container(),
                    TextWidget(
                        title: title,
                        textColor: textColor ?? AppColor.whiteColor,
                        fontSize: fontSize)
                  ],
                ),
              ),
            ))
      ],
    );
  }
}
