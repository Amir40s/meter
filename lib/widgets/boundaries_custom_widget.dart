import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/widgets/text_widget.dart';

import '../constant/res/app_color/app_color.dart';
import 'custom_button.dart';
import 'custom_linear_progress.dart';
import 'custom_textfield.dart';

class BoundariesCustomWidget extends StatelessWidget {
  final String header;
  final double progressValue;
  final TextEditingController boundariesByNatureController;
  final TextEditingController boundariesByNatureHeightController;
  final TextEditingController boundariesByDeedController;
  final TextEditingController boundariesByDeedHeightController;
  final TextEditingController boundariesByPlanController;
  final TextEditingController boundariesByPlanHeightController;
  final String buttonText;
  final VoidCallback onTap;
  const BoundariesCustomWidget({
    super.key,
    required this.header,
    this.buttonText = "Next Direction",
    required this.progressValue,
    required this.boundariesByNatureController,
    required this.boundariesByNatureHeightController,
    required this.boundariesByDeedController,
    required this.boundariesByDeedHeightController,
    required this.boundariesByPlanController,
    required this.boundariesByPlanHeightController,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          )),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              CustomLinearProgress(value: progressValue),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: TextWidget(
                  title: header,
                  fontSize: 18,
                  textColor: AppColor.semiDarkGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              customRow(
                  hintText: "Enter boundaries",
                  title: "Boundaries by nature",
                  boundaryController: boundariesByNatureController,
                  heightController: boundariesByNatureHeightController),
              SizedBox(
                height: Get.height * 0.02,
              ),
              customRow(
                  hintText: "Enter boundaries",
                  title: "Boundaries by deed",
                  boundaryController: boundariesByDeedController,
                  heightController: boundariesByDeedHeightController),
              SizedBox(
                height: Get.height * 0.02,
              ),
              customRow(
                  hintText: "Enter boundaries",
                  title: "Boundaries by plan",
                  boundaryController: boundariesByPlanController,
                  heightController: boundariesByPlanHeightController),
              SizedBox(
                height: Get.height * 0.04,
              ),
              CustomButton(title: buttonText, onTap: onTap)
            ],
          ),
        ),
      ),
    );
  }

  Widget customRow({
    required String hintText,
    required String title,
    required TextEditingController boundaryController,
    required TextEditingController heightController,
  }) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
              hintText: hintText, title: title, controller: boundaryController),
        ),
        SizedBox(
          width: Get.width * 0.02,
        ),
        Expanded(
          child: CustomTextField(
              hintText: "Enter height",
              title: "Height",
              controller: heightController),
        ),
      ],
    );
  }
}
