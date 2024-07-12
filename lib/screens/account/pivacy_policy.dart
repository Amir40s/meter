import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/res/app_color/app_color.dart';
import '../../controller/account/profile_controller.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/text_widget.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.03,
              ),
              CustomHeader(title: "Privacy Policy".tr),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: TextWidget(
                    textAlign: TextAlign.start,
                    title: controller.privacyPolicy,
                    textColor: AppColor.semiTransparentDarkGrey,
                    fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}
