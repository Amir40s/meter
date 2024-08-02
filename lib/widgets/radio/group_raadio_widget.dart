import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/prefUtils/pref_utils.dart';
import '../../constant/res/app_color/app_color.dart';
import '../text_widget.dart';

Widget rowWithRadio(
    String title, String groupValue, String value, Function(String?)? onChanged,
    {double fontSize = 14}) {
  return GestureDetector(
    onTap: () {
      onChanged!(value);
    },
    child: Row(
      children: [
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: AppColor.primaryColor,
        ),
        TextWidget(
            title: title, textColor: AppColor.semiDarkGrey, fontSize: fontSize)
      ],
    ),
  );
}

Widget columnWithRadio(String title, String groupValue, String value,
    Function(String?)? onChanged, bool active, VoidCallback onTap,
    {double fontSize = 14}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: Get.height * 0.1368,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: active
                  ? AppColor.primaryColor
                  : AppColor.semiTransparentDarkGrey)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.translate(
            offset: const Offset(-11, 0),
            child: Radio(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: AppColor.primaryColor,
            ),
          ),
          TextWidget(
              title: title,
              textColor: active
                  ? AppColor.semiDarkGrey
                  : AppColor.semiTransparentDarkGrey,
              textAlign: TextAlign.start,
              fontSize: fontSize)
        ],
      ),
    ),
  );
}

Widget filledContainerWithRadio(String title, String groupValue, String value,
    Function(String?)? onChanged, bool active,
    {double fontSize = 14}) {
  bool? isEnglish = PrefUtil.getBool(PrefUtil.language) ?? true;
  return GestureDetector(
    onTap: () {
      onChanged!(value);
    },
    child: Container(
      padding: const EdgeInsets.only(left: 12, right: 12),
      decoration: BoxDecoration(
          color: active ? AppColor.primaryShade : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: active
                  ? AppColor.primaryColor
                  : AppColor.semiTransparentDarkGrey)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: Get.width * 0.70,
              child: TextWidget(
                title: title,
                textAlign: isEnglish ? TextAlign.left : TextAlign.right,
                textColor: active
                    ? AppColor.semiDarkGrey
                    : AppColor.semiTransparentDarkGrey,
                fontSize: fontSize,
              )),
          const Spacer(),
          Transform.translate(
            offset: const Offset(-11, 0),
            child: Radio(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: AppColor.primaryColor,
            ),
          ),
        ],
      ),
    ),
  );
}
