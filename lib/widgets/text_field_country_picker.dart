import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/widgets/text_widget.dart';

import '../constant.dart';
import '../constant/res/app_color/app_color.dart';

class TextFieldCountryPicker extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final EdgeInsets padding;
  final double borderRadius;
  final String flagPath;
  final String? countryShortCode;
  final String? countryDialingCode;
  final Function(CountryCode)? countryCode;
  final String title;
  final String? richText;
  final VoidCallback? onTapSuffix;
  final String verifyText;
  final Color verifyColor;
  final bool isVerifySucces;
  const TextFieldCountryPicker({
    super.key,
    required this.hintText,
    this.isVerifySucces = false,
    required this.controller,
    this.validator,
    this.padding = const EdgeInsets.fromLTRB(0, 14, 0, 14),
    this.borderRadius = 30.0,
    required this.flagPath,
    this.countryCode,
    this.countryShortCode,
    this.countryDialingCode,
    required this.title,
    this.richText,
    this.onTapSuffix,
    this.verifyText = "Verify",
    this.verifyColor = AppColor.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Get.height * 0.02,
        ),
        Text(
          title,
          style: AppTextStyle.dark14.copyWith(
              color: AppColor.semiDarkGrey, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColor.greyColor, // Border color
              width: 1.0, // Border width
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 13.0, right: 0.0),
                child: Image.asset(
                  flagPath,
                  width: 30,
                  package: 'country_code_picker',
                ),
              ),
              Expanded(
                child: TextFormField(
                  cursorColor: AppColor.primaryColor,
                  keyboardType: TextInputType.number,
                  controller: controller,
                  readOnly: isVerifySucces,
                  decoration: InputDecoration(
                      hintText: hintText,
                      contentPadding: const EdgeInsets.only(
                        top: 14,
                        bottom: 10,
                      ),
                      border: InputBorder.none,
                      prefixIcon: isVerifySucces
                          ? Padding(
                              padding: const EdgeInsets.only(
                                top: 14,
                                bottom: 10,
                              ),
                              child: TextWidget(
                                title: countryShortCode!,
                                textColor: AppColor.primaryColor,
                              ),
                            )
                          : CountryCodePicker(
                              searchDecoration: InputDecoration(
                                prefixIconColor:
                                    AppColor.semiTransparentDarkGrey,
                                hintText: "Search".tr,
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: AppColor.semiTransparentDarkGrey),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: AppColor.semiTransparentDarkGrey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: AppColor
                                        .primaryColor, // Use your desired color for the focused border
                                    width:
                                        2.0, // You can customize the width of the focused border
                                  ),
                                ),
                              ),
                              initialSelection: countryShortCode ?? 'SA',
                              textStyle: AppTextStyle.dark14
                                  .copyWith(color: AppColor.primaryColor),
                              favorite: [
                                countryDialingCode ?? '+966',
                                countryShortCode ?? 'SA'
                              ],
                              showFlagMain: false,
                              showDropDownButton: false,
                              padding: EdgeInsets.zero,
                              onChanged: countryCode,
                              dialogTextStyle: AppTextStyle.dark14,
                              dialogSize: Size(Get.width, Get.height * 0.6),
                              showFlag: true,
                              showFlagDialog: true,
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              boxDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColor.whiteColor),
                            ),
                      suffixIcon: onTapSuffix != null
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  top: 14, bottom: 10, right: 10),
                              child: InkWell(
                                onTap: onTapSuffix,
                                child: TextWidget(
                                  title: verifyText,
                                  textColor: verifyColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : null),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
