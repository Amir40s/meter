import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/widgets/text_widget.dart';
import '../constant/res/app_color/app_color.dart';
import '../constant/res/app_images/app_images.dart';
import '../screens/chat/chat_detail.dart';
import 'circular_container.dart';
import 'custom_button.dart';

class RatingContainer extends StatelessWidget {
  const RatingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.transparent),
      child: Column(
        children: [
          Transform.translate(
            offset: Offset(-12, 3),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(AppImage.profile),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                        textAlign: TextAlign.start,
                        title: "David Wayne",
                        textColor: AppColor.semiDarkGrey,
                        fontSize: 16),
                    TextWidget(
                        title: "Engineering Office",
                        textColor: AppColor.semiTransparentDarkGrey,
                        fontSize: 15)
                  ],
                ),
                Transform.translate(
                  offset: Offset(-9, -9),
                  child: Image.asset(
                    AppImage.rating,
                    height: 14,
                  ),
                ),
                CircularContainer(
                  backgroundColor: AppColor.success10,
                  imagePath: AppImage.chatActive,
                  onTap: () {
                    Get.to(ChatDetail());
                  },
                ),
                CircularContainer(
                  backgroundColor: AppColor.primaryColor,
                  widget: const TextWidget(
                    textColor: AppColor.whiteColor,
                    title: "\n50\nSAR\n",
                    fontSize: 16,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
          TextWidget(
              textAlign: TextAlign.start,
              title:
                  "Lorem ipsum dolor sit amet consectetur. Dignissim tortor dictum justo lorem suspendisse turpis integer eu. Elementum commodo ultrices sodales sed leo. Sed elit quis nisi laoreet mauris bibendum..",
              textColor: AppColor.semiTransparentDarkGrey,
              fontSize: 12),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Row(
            children: [
              Expanded(
                  child: MyCustomButton(
                title: "Decline",
                onTap: () {},
                textColor: AppColor.primaryColor,
                backgroundColor: AppColor.whiteColor,
                borderSideColor: AppColor.primaryColor,
              )),
              SizedBox(
                width: Get.width * 0.02,
              ),
              Expanded(
                child: CustomButton(title: "Accept", onTap: () {}),
              )
            ],
          )
        ],
      ),
    );
  }
}
