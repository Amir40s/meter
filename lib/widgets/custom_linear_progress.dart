import 'package:flutter/material.dart';

import '../constant/res/app_color/app_color.dart';

class CustomLinearProgress extends StatelessWidget {
  final double value;
  final Color activeColor;
  final Color backgroundColor;
  const CustomLinearProgress(
      {super.key,
        required this.value,
        this.activeColor = AppColor.primaryColor,
        this.backgroundColor = AppColor.semiTransparentDarkGrey});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      valueColor: AlwaysStoppedAnimation<Color>(activeColor),
      backgroundColor: backgroundColor,
      minHeight: 4,
    );
  }
}
