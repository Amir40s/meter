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
  final String time;
  final String profileImage;
  final String location;
  final String title;
  final VoidCallback onTap;
  final String description;
  const RequestWidget(
      {super.key,
      required this.buttonText,
      required this.time,
      required this.profileImage,
      required this.location,
      required this.description,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColor.lightGreyShade),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextWidget(
                      title: "Survey Report",
                      textColor: AppColor.primaryColor,
                      fontSize: 14),
                  Spacer(),
                  TextWidget(
                      title: time,
                      textColor: AppColor.primaryColor,
                      fontSize: 12)
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
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColor.primaryColor,
                        backgroundImage: NetworkImage(profileImage),
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
                                AppImage.activeLocation,
                                width: 18,
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              SizedBox(
                                width: Get.width * 0.50,
                                child: TextWidget(
                                  textColor: AppColor.semiTransparentDarkGrey,
                                  fontSize: 14,
                                  title: location,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
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
                  title: description,
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
      ),
    );
  }
}
