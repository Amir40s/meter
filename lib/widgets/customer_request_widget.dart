import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant.dart';
import 'package:meter/model/requestServices/request_services_model.dart';
import 'package:meter/widgets/text_widget.dart';

import '../constant/res/app_color/app_color.dart';
import '../constant/res/app_images/app_images.dart';
import '../screens/requests/request_detail.dart';
import '../screens/requests/request_info.dart';
import 'avatar_list.dart';
import 'custom_button.dart';

class CustomerRequestsContainer extends StatelessWidget {
  final String status;
  final List<String>? imagePath;
  final String? imageLabel;
  final bool showAvatar;
  final RequestServicesModel model;
  const CustomerRequestsContainer(
      {super.key,
        required this.status,
        this.imagePath,
        this.imageLabel,
        this.showAvatar = true, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (status == "Completed") {
          Get.to(RequestDetail());
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColor.lightGreyShade),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(
                children: [
                  TextWidget(
                      title: model.activityType,
                      textColor: AppColor.primaryColor,
                      fontSize: 14),
                  const Spacer(),
                  TextWidget(
                      title: status == "New" ? convertTimestamp(model.timestamp.toString()).toString() : status,
                      textColor: status == "new"
                          ? AppColor.primaryColor
                          : status == "Active"
                          ? AppColor.greenColor
                          : AppColor.semiDarkGrey,
                      fontSize: 12)
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        title: model.applicationName,
                        textColor: AppColor.semiDarkGrey,
                        fontSize: 18,
                      ),
                      Row(
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
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              TextWidget(
                title:
                model.details,
                textColor: AppColor.semiTransparentDarkGrey,
                fontSize: 12,
                textAlign: TextAlign.start,
              ),
              if (showAvatar) ...[
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Row(
                  children: [
                    AvatarList(imagePaths: imagePath!),
                    SizedBox(
                      width: Get.width * 0.05,
                    ),
                    TextWidget(
                        title: imageLabel!,
                        textColor: AppColor.semiTransparentDarkGrey,
                        fontSize: 12),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                status == "2m"
                    ? MyCustomButton(
                  padding: 12,
                  title: "View All Proposal",
                  onTap: () {
                    //  Get.to( RequestInfo());
                  },
                  borderSideColor: AppColor.primaryColor,
                  textColor: AppColor.primaryColor,
                  backgroundColor: AppColor.lightGreyShade,
                )
                    : Container()
              ]
            ],
          ),
        ),
      ),
    );
  }
}
