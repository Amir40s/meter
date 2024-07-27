import 'package:flutter/material.dart';

import '../constant/res/app_color/app_color.dart';

class CircularContainer extends StatelessWidget {
  final double padding;
  final String? imagePath;
  final Color backgroundColor;
  final VoidCallback onTap;
  final VoidCallback? onSecondTap;
  final Widget? widget;
  final double imageSize;
  const CircularContainer(
      {super.key,
      this.padding = 8,
      this.imagePath,
      this.backgroundColor = AppColor.primaryColor,
      required this.onTap,
       this.onSecondTap,
      this.widget,
      this.imageSize = 30});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onSecondaryTap: onSecondTap,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
        ),
        child: Center(
            child: widget ??
                Image.asset(
                  imagePath!,
                  width: imageSize,
                )),
      ),
    );
  }
}
