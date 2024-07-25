
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/prefUtils/pref_utils.dart';
import '../constant/res/app_color/app_color.dart';
import '../constant/res/app_images/app_images.dart';

class CustomBackButton extends StatelessWidget {
  final Color? backgroundColor;
  final VoidCallback? onTap;
  const CustomBackButton({super.key, this.backgroundColor, this.onTap});
  @override
  Widget build(BuildContext context) {
    bool? isEnglish = PrefUtil.getBool(PrefUtil.language) ?? true;
    return GestureDetector(
      onTap: onTap ??
              () {
            Get.back();
          },
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
            color: backgroundColor ?? Colors.transparent,
            shape: BoxShape.circle,
            border:
            Border.all(color: AppColor.semiTransparentDarkGrey, width: 1)),
        child: Center(
            child: Image.asset(
             isEnglish ? AppImage.back : AppImage.arabicBack,
              width: 24,
            )),
      ),
    );
  }
}
