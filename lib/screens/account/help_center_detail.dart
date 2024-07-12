import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/res/app_color/app_color.dart';
import '../../controller/account/profile_controller.dart';
import '../../widgets/text_widget.dart';

class HelpCenterDetail extends StatelessWidget {
  final String title;
  const HelpCenterDetail({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return Container(
      height: Get.height * 0.85,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.03,
              ),
              Align(
                alignment: Alignment.center,
                child: TextWidget(
                    textAlign: TextAlign.start,
                    title: "Help".tr,
                    textColor: AppColor.semiDarkGrey,
                    fontSize: 16),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              TextWidget(
                title: title,
                textColor: AppColor.semiDarkGrey,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              TextWidget(
                textAlign: TextAlign.start,
                title: controller.helpDetail.tr,
                textColor: AppColor.semiTransparentDarkGrey,
                fontSize: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
