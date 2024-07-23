import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/bottomSheet/requestForm/request_form_bottom_sheet.dart';
import 'package:meter/model/requestServices/request_services_model.dart';
import 'package:meter/widgets/text_widget.dart';
import 'package:meter/widgets/timestamp_converter.dart';

import '../constant/language/language_utils.dart';
import '../constant/res/app_color/app_color.dart';
import '../constant/res/app_images/app_images.dart';
import 'custom_button.dart';
import 'image_loader_widget.dart';

class RequestWidget extends StatelessWidget {
  final String buttonText,activityType;
  final RequestServicesModel model;
  const RequestWidget({
    super.key,
    required this.buttonText,
    required this.activityType,
    required this.model,
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
                    title: activityType,
                    textColor: AppColor.primaryColor,
                    fontSize: 14),
                Spacer(),
                TimestampConverter(timestampString: model.timestamp.toString(),)
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
                      margin: EdgeInsets.only(left: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: ImageLoaderWidget(imageUrl: model.userProfileImage,),
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
                          title: model.specializations,
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
                            TextWidget(
                              textColor: AppColor.semiTransparentDarkGrey,
                              fontSize: 14,
                              title: model.location,
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
                model.details,
                textColor: AppColor.semiTransparentDarkGrey,
                fontSize: 12),
            SizedBox(
              height: Get.height * 0.03,
            ),
            CustomButton(
                title: buttonText,
                onTap: () {
                  Get.bottomSheet(
                    RequestFormBottomSheet(model: model,),
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
