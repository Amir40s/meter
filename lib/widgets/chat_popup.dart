import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/bottomSheet/requestForm/request_form_bottom_sheet.dart';
import 'package:meter/widgets/request_widget.dart';
import 'package:meter/widgets/text_widget.dart';

import '../constant/res/app_color/app_color.dart';
import '../constant/res/app_images/app_images.dart';
import 'circular_container.dart';

class ChatAddBottomSheet extends StatelessWidget {
  const ChatAddBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: Get.height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              twoWidgets(
                  imagePath: AppImage.offer,
                  onTap: () {
                    Get.bottomSheet(
                      const RequestFormBottomSheet(
                        showPicture: false,
                      ),
                      isScrollControlled: false,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    );
                  },
                  title: "Create an offer".tr),
              twoWidgets(
                  imagePath: AppImage.pickLocation,
                  onTap: () {
                    log("Location tap");
                    // Get.back();
                  },
                  iconSize: 25.0,
                  title: "Location".tr)
            ],
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              twoWidgets(
                  imagePath: AppImage.record, onTap: () {}, title: "Record".tr),
              Transform.translate(
                offset: Offset(Get.width * 0.05, 0),
                child: twoWidgets(
                  imagePath: AppImage.gallery,
                  onTap: () {},
                  iconSize: 25.0,
                  title: "Gallery".tr,
                ),
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.03,
          ),
        ],
      ),
    );
  }

  Widget twoWidgets(
      {required imagePath, required onTap, required title, iconSize = 30.0}) {
    return Column(
      children: [
        CircularContainer(
          imagePath: imagePath,
          onTap: onTap,
          imageSize: iconSize,
        ),
        const SizedBox(
          height: 9,
        ),
        TextWidget(
            title: title, textColor: AppColor.semiDarkGrey, fontSize: 16),
      ],
    );
  }
}

class ChatPopupMenu extends StatelessWidget {
  const ChatPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: Offset(0, Get.height * 0.06),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      icon: Image.asset(AppImage.menu),
      onSelected: (String result) {
        switch (result) {
          case 'Report':
            print('Report selected');
            break;
          case 'Block':
            print('Block selected');
            break;
          case 'Delete Chat':
            print('Delete Chat selected');
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Report',
          child: TextWidget(
              title: "Report".tr,
              textColor: AppColor.semiDarkGrey,
              fontSize: 16),
        ),
        PopupMenuItem<String>(
          value: 'Block'.tr,
          child: TextWidget(
              title: "Block".tr,
              textColor: AppColor.semiDarkGrey,
              fontSize: 16),
        ),
        PopupMenuItem<String>(
          value: 'Delete Chat',
          child: TextWidget(
              title: "Delete Chat".tr,
              textColor: AppColor.semiDarkGrey,
              fontSize: 16),
        ),
      ],
      color: Colors.white, // Set the background color of the popup menu
    );
  }
}
