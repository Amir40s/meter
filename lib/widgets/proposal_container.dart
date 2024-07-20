import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/model/requestServices/request_services_model.dart';
import 'package:meter/model/requestServices/send_request_model.dart';
import 'package:meter/widgets/text_widget.dart';

import '../constant/res/app_color/app_color.dart';
import '../constant/res/app_images/app_images.dart';
import '../screens/send_work/send_work_main.dart';
import 'avatar_list.dart';
import 'custom_button.dart';

class ProposalContainer extends StatelessWidget {
  final String status,applicationName,location;
  final String date;
  final List<SendRequestModel> imagePath;
  final String imageLabel;


   ProposalContainer(
      {super.key,
      required this.status,
      required this.imagePath,
      required this.imageLabel,
        required this.date,
        required this.applicationName, required this.location,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    title: date,
                    textColor: AppColor.primaryColor,
                    fontSize: 14),
                const Spacer(),
                TextWidget(
                    title: status,
                    textColor: status == "New"
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 26,
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
                      title: applicationName,
                      textColor: AppColor.semiDarkGrey,
                      fontSize: 18,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          textOverflow: TextOverflow.ellipsis,
                          title: location ?? "",
                                                 ),
                      ],
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Row(
              children: [
                AvatarModelList(imagePaths: imagePath),
                SizedBox(
                  width: Get.width * 0.05,
                ),
                TextWidget(
                    title: imageLabel,
                    textColor: AppColor.semiTransparentDarkGrey,
                    fontSize: 12),
              ],
            ),
            if (status == "Active") ...[
              SizedBox(
                height: Get.height * 0.02,
              ),
              MyCustomButton(
                title: "Send Work",
                onTap: () {
                  // Get.to(DeliveringServiceMain());
                  Get.to(const SendWork());
                  // Get.to(ConsolationDeliveryMain());
                },
                textColor: AppColor.primaryColor,
                backgroundColor: Colors.transparent,
                borderSideColor: AppColor.primaryColor,
                padding: 12,
              )
            ]
          ],
        ),
      ),
    );
  }
}
