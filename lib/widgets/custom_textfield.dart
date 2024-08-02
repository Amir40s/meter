import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';
import '../constant/language/language_utils.dart';
import '../constant/prefUtils/pref_utils.dart';
import '../constant/res/app_color/app_color.dart';
import '../constant/res/app_images/app_images.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final int maxLine;
  final bool showSuffix;
  final Color? dropDownColor;
  final String? Function(String?)? validator;
  final bool isObscure;
  final TextEditingController controller;
  final Color? hintTextColor;
  final VoidCallback? onSuffixIconTap;
  final TextInputType textInputType;
  final bool isPhoneNumber;
  final String? prefixImagePath;
  final bool readOnly;
  final String richText;
  final Function(String)? onChanged;
  final List<dynamic>? dropDownItems;
  final Function(dynamic)? onChangeDropDown;
  final VoidCallback? onTap;
  final bool showSpace;
  final Color? fillColor;
  const CustomTextField(
      {super.key,
        required this.hintText,
        required this.title,
        this.maxLine = 1,
        this.readOnly = false,
        this.showSuffix = false,
        this.isObscure = false,
        this.onSuffixIconTap,
        this.textInputType = TextInputType.text,
        this.prefixImagePath,
        this.dropDownItems,
        this.onChangeDropDown,
        this.isPhoneNumber = false,
        this.richText = "",
        this.hintTextColor,
        required this.controller,
        this.showSpace = false,
        this.validator,
        this.onTap,
        this.fillColor,
        this.onChanged,
        this.dropDownColor});

  @override
  Widget build(BuildContext context) {
    bool? isEnglish = PrefUtil.getBool(PrefUtil.language) ?? true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        !showSpace
            ? SizedBox(
          height: Get.height * 0.02,
        )
            : Container(),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: title.tr,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: " ${richText.tr}", style: AppTextStyle.dark14)
            ],

            style: AppTextStyle.dark14.copyWith(color: AppColor.semiDarkGrey),
            // Add more TextSpans if you want to format different parts differently
          ),
        ),
        !showSpace
            ? SizedBox(
          height: Get.height * 0.01,
        )
            : Container(),
        TextFormField(
          onTap: onTap,
          onChanged: onChanged,
          controller: controller,
          validator: validator,
          keyboardType: textInputType,
          obscureText: isObscure,
          maxLines: maxLine,
          readOnly: readOnly,
          cursorColor: AppColor.primaryColor,
          decoration: InputDecoration(
            hintText: hintText.tr,
            hintStyle: AppTextStyle.dark14.copyWith(
              color: hintTextColor ?? AppColor.semiTransparentDarkGrey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColor.semiTransparentColor, // Border color
                width: 1.0, // Border width
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColor.greyColor, // Border color
                width: 1.0, // Border width
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColor.primaryColor, // Border color when focused
                width: 1.0, // Border width when focused
              ),
            ),
            prefixIcon: prefixImagePath != null
                ? Padding(
              padding:
              const EdgeInsets.all(10), // Adjust padding as needed
              child: Image.asset(
                prefixImagePath!,
                width: 30,
              ),
            )
                : null,
            fillColor: fillColor ?? AppColor.whiteColor,
            filled: true,
            suffixIcon: showSuffix
                ? IconButton(
              onPressed: onSuffixIconTap,
              icon: Image.asset(
                isObscure ? AppImage.hide : AppImage.show,
                width: 18,
              ),
            )
                : dropDownItems != null
                ? DropdownButtonHideUnderline(
              child: DropdownButton<dynamic>(
                items: dropDownItems!
                    .map<DropdownMenuItem<dynamic>>((dynamic value) {
                  print("Value is $value");
                  return DropdownMenuItem<dynamic>(
                    value: value,
                    child: Text(
                      value.toString().tr,
                      style: AppTextStyle.dark14
                          .copyWith(color: AppColor.semiDarkGrey),
                    ),
                  );
                }).toList(),
                isDense: false,

                onChanged: onChangeDropDown,
                iconEnabledColor: AppColor.primaryColor,
                alignment: Alignment.center,
                iconDisabledColor: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(12),
                style: AppTextStyle.dark14
                    .copyWith(color: AppColor.semiDarkGrey),
                dropdownColor: Theme.of(context)
                    .canvasColor, // Dropdown background color
                icon: Padding(
                  padding: EdgeInsets.only(right: isEnglish ? 10 : 0,left: isEnglish ? 0 : 10),
                  child: Image.asset(
                    AppImage.downArrow,
                    width: 18,
                    color: dropDownColor ?? AppColor.semiDarkGrey,
                  ),
                ),
                elevation: 6,
                isExpanded: false,
              ),
            )
                : null,
            contentPadding:
            const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
          ),
          style: AppTextStyle.dark14.copyWith(color: AppColor.semiDarkGrey),
        )
      ],
    );
  }
}
