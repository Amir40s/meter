import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../constant/res/app_color/app_color.dart';
import '../../controller/store_controller/rating_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/text_widget.dart';

class ServiceRating extends StatelessWidget {
  const ServiceRating({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RatingController());
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const CustomHeader(title: "Service Rating"),
            SizedBox(
              height: Get.height * 0.03,
            ),
            const CircleAvatar(
              radius: 70,
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            const TextWidget(
              title: "Eltawhed Office",
              textColor: AppColor.semiDarkGrey,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            const TextWidget(
              title: "Engineering Office",
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Obx(
              () => RatingBar.builder(
                initialRating: controller.initialRating.value,
                minRating: 0.5,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                unratedColor: AppColor.yellowShade,
                itemSize: 50,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: AppColor.semiTransparentDarkGrey,
                ),
                onRatingUpdate: (rating) {
                  controller.updateRating(rating);
                },
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: CustomTextField(
                  maxLine: 5,
                  hintText: "Type your review",
                  showSpace: true,
                  title: "",
                  controller: controller.reviewController),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  Expanded(
                      child: MyCustomButton(
                    onTap: () {},
                    title: "Skip",
                    backgroundColor: AppColor.lightBlueShade,
                    textColor: AppColor.primaryColor,
                  )),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                      child: MyCustomButton(
                    onTap: () {},
                    title: "Submit",
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
