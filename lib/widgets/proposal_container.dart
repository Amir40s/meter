import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/widgets/text_widget.dart';

import '../constant/res/app_color/app_color.dart';
import '../constant/res/app_images/app_images.dart';
import '../screens/send_work/send_work_main.dart';
import 'avatar_list.dart';
import 'custom_button.dart';

class ProposalContainer extends StatelessWidget {
  final String status;
  final List<String> imagePath;
  final String imageLabel;
  const ProposalContainer(
      {super.key,
      required this.status,
      required this.imagePath,
      required this.imageLabel});

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
                const TextWidget(
                    title: "10/05/2024",
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
                    const TextWidget(
                      title: "Survey Report",
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
                        const TextWidget(
                          textColor: AppColor.semiTransparentDarkGrey,
                          fontSize: 14,
                          title: "Makka,Saudi Arabia",
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
                AvatarList(imagePaths: imagePath),
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
