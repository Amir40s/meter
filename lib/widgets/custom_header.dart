import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/widgets/text_widget.dart';

import '../constant/res/app_color/app_color.dart';
import 'custom_back_button.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final bool showProgress;
  final double progressWidth;
  final bool showLoadingPadding;
  const CustomHeader(
      {super.key,
        required this.title,
        this.showProgress = false,
        this.progressWidth = 3,
        this.showLoadingPadding = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Get.height * 0.02,
        ),
        Padding(
          padding:
          const EdgeInsets.only(left: 14.0, right: 5, top: 14, bottom: 14),
          child: Row(
            children: [
              const CustomBackButton(),
              const Spacer(),
              SizedBox(
                width: Get.width * 0.60,
                child: TextWidget(
                  title: title,
                  textColor: AppColor.semiDarkGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(),
            ],
          ),
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        showProgress
            ? Align(
          alignment: Alignment.topLeft,
          child: Container(
            color: AppColor.primaryColor,
            height: 4,
            width: Get.width / progressWidth,
          ),
        )
            : Container(),
      ],
    );
  }
}
