import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/bottomSheet/requestForm/request_form_bottom_sheet.dart';
import 'package:meter/widgets/text_widget.dart';

import '../constant/language/language_utils.dart';
import '../constant/res/app_color/app_color.dart';
import '../constant/res/app_images/app_images.dart';
import 'custom_button.dart';

class RequestWidget extends StatelessWidget {
  final String buttonText;
  const RequestWidget({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColor.lightGreyShade),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            const Row(
              children: [
                TextWidget(
                    title: "Survey Report",
                    textColor: AppColor.primaryColor,
                    fontSize: 14),
                Spacer(),
                TextWidget(
                    title: "2m", textColor: AppColor.primaryColor, fontSize: 12)
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
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColor.primaryColor,
                      backgroundImage: AssetImage(AppImage.dummySketch),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextWidget(
                          title: "Construction Estimation",
                          textColor: AppColor.semiDarkGrey,
                          fontSize: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              AppImage.activeLocation,
                              width: 18,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            const TextWidget(
                              textColor: AppColor.semiTransparentDarkGrey,
                              fontSize: 14,
                              title: "Makka,Saudi Arabia",
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
            const TextWidget(
                textAlign: TextAlign.start,
                title:
                "Lorem ipsum dolor sit amet consectetur. Dignissim tortor dictum justo lorem suspendisse turpis integer eu. Elementum commodo ultrices sodales sed leo. Sed elit quis nisi laoreet mauris bibendum..",
                textColor: AppColor.semiTransparentDarkGrey,
                fontSize: 12),
            SizedBox(
              height: Get.height * 0.03,
            ),
            CustomButton(
                title: buttonText,
                onTap: () {
                  Get.bottomSheet(
                    const RequestFormBottomSheet(),
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
