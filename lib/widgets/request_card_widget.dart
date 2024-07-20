import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/bottomSheet/requestForm/request_form_bottom_sheet.dart';
import 'package:meter/model/requestServices/request_services_model.dart';
import 'package:meter/widgets/image_loader_widget.dart';
import 'package:meter/widgets/text_widget.dart';
import 'package:meter/widgets/timestamp_converter.dart';

import '../constant/language/language_utils.dart';
import '../constant/res/app_color/app_color.dart';
import '../constant/res/app_images/app_images.dart';
import '../model/requestServices/send_request_model.dart';
import 'custom_button.dart';

class RequestCardWidget extends StatelessWidget {
  final String topRightText,topLeftText,title,subtitle,profileImage,details;
  String subtitleIconPath,buttonText;
  VoidCallback? press;
  RequestCardWidget({
    super.key,
     this.topRightText = "",
     this.topLeftText = "",
     this.title = "",
     this.subtitle = "",
     this.profileImage = "",
     this.details = "",
    this.subtitleIconPath = AppImage.activeLocation,
    this.buttonText = "Apply",
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColor.lightGreyShade),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextWidget(
                    title: topLeftText,
                    textColor: AppColor.primaryColor,
                    fontSize: 14),
                Spacer(),
                TextWidget(
                    title: topRightText,
                    textColor: AppColor.primaryColor,
                    fontSize: 14),
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              child: Transform.translate(
                offset: Offset(LanguageUtils.isEnglishLang() ? -14 : 14, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50.0,
                      height: 50.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: ImageLoaderWidget(imageUrl: profileImage,),
                      ),
                    ),

                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          title: title,
                          textColor: AppColor.semiDarkGrey,
                          fontSize: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              subtitleIconPath,
                              width: 18,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            TextWidget(
                              textColor: AppColor.semiTransparentDarkGrey,
                              fontSize: 14,
                              title: subtitle,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            TextWidget(
                textAlign: TextAlign.start,
                title:
                details,
                textColor: AppColor.semiTransparentDarkGrey,
                fontSize: 12),
            SizedBox(
              height: Get.height * 0.03,
            ),
            CustomButton(
                title: buttonText,
                onTap: press ?? (){}
            )
          ],
        ),
      ),
    );
  }
}
