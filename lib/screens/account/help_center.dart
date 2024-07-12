import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../controller/account/profile_controller.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/text_widget.dart';
import 'help_center_detail.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              CustomHeader(title: "Help Center".tr),
              // Transform.translate(
              //   offset: const Offset(0, -22),
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 14.0),
              //     child: CustomTextField(
              //       hintText: "Search".tr,
              //       title: "",
              //       prefixImagePath: AppImage.search,
              //     ),
              //   ),
              // ),

              Padding(
                padding: const EdgeInsets.all(14.0),
                child: CustomTextField(
                    controller: TextEditingController(),
                    prefixImagePath: AppImage.search,
                    showSpace: true,
                    hintText: "Search".tr,
                    title: ""),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: SizedBox(
                  height: 50,
                  child: ListView.separated(
                    itemCount: controller.helpList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (itemBuilder, index) {
                      return Obx(() => GestureDetector(
                            onTap: () {
                              controller.onChangeSelectedIndex(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: controller.selectedIndex.value == index
                                      ? AppColor.primaryColor
                                      : AppColor.lightGreyShade),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    controller.selectedIndex.value == index
                                        ? Image.asset(
                                            AppImage.correct,
                                            width: 12,
                                          )
                                        : Container(),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    TextWidget(
                                        title: controller.helpList[index]
                                            .toString()
                                            .tr,
                                        textColor:
                                            controller.selectedIndex.value ==
                                                    index
                                                ? AppColor.whiteColor
                                                : AppColor.semiDarkGrey,
                                        fontSize: 12)
                                  ],
                                ),
                              ),
                            ),
                          ));
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        width: 10,
                      );
                    },
                  ),
                ),
              ),
              ListView.builder(
                  itemCount: 8,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (itemBuilder, index) {
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: GestureDetector(
                        onTap: () {
                          print("How do I create a new account?".tr);
                          Get.bottomSheet(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              HelpCenterDetail(
                                  title: "How do I create a new account?".tr),
                              backgroundColor: AppColor.whiteColor);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                                child: TextWidget(
                                    title: "How do I create a new account?".tr,
                                    textColor: AppColor.semiDarkGrey,
                                    fontSize: 16)),
                            const SizedBox(width: 10.0),
                            Image.asset(
                              AppImage.leftSide,
                              width: 24,
                            )
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
