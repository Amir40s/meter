import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/widgets/text_widget.dart';

import '../constant/res/app_color/app_color.dart';
import '../constant/res/app_images/app_images.dart';

class DeviceWidget extends StatelessWidget {
  final String date;
  final String imageUrl;
  final VoidCallback onClick;
  final String deviceName;
  final String deviceModel;
  final VoidCallback onDeleteTap;
  final VoidCallback onEditTap;
  const DeviceWidget(
      {super.key,
      required this.date,
      required this.onClick,
      required this.deviceName,
      required this.deviceModel,
      required this.onDeleteTap,
      required this.onEditTap,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // EditPopUp(
              //   onEditTap: onEditTap,
              //   onDeleteTap: onDeleteTap,
              // ),
              const Spacer(),
              Row(
                children: [
                  Image.asset(
                    AppImage.clock,
                    width: 12,
                  ),
                  TextWidget(
                      title: date,
                      textColor: AppColor.semiTransparentDarkGrey,
                      fontSize: 12),
                ],
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Image.network(
            imageUrl,
            fit: BoxFit.contain,
            width: Get.width,
            height: Get.height * 0.3,
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                    title: deviceName,
                    textColor: AppColor.semiDarkGrey,
                    textAlign: TextAlign.start,
                    fontSize: 12),
                TextWidget(
                    textAlign: TextAlign.start,
                    title: deviceModel,
                    textColor: AppColor.semiTransparentDarkGrey,
                    fontSize: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
