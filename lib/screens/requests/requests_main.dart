import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant.dart';
import 'package:meter/model/requestServices/request_services_model.dart';
import 'package:meter/provider/firebase_services.dart';
import 'package:meter/screens/requests/components/request_services_widget.dart';
import 'package:provider/provider.dart';

import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../controller/bottomNav/bottom_nav_controller_main.dart';
import '../../controller/provider_controller/proposal_controller.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/customer_request_widget.dart';
import '../../widgets/text_widget.dart';

class RequestsMain extends StatelessWidget {
  const RequestsMain({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProposalController());
    final bottomController = Get.find<BottomNavController>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: TextWidget(
                  title: "Requests",
                  textColor: AppColor.semiDarkGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomTextField(
                controller: controller.searchController,
                hintText: "Search",
                title: "",
                prefixImagePath: AppImage.search,
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              SizedBox(
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
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: controller.selectedIndex.value == index
                                    ? AppColor.primaryColor
                                    : AppColor.lightGreyShade),
                            child: Center(
                                child: TextWidget(
                                    title: controller.helpList[index]
                                        .toString()
                                        .tr,
                                    textColor:
                                        controller.selectedIndex.value == index
                                            ? AppColor.whiteColor
                                            : AppColor.semiDarkGrey,
                                    fontSize: 14)),
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
              SizedBox(
                height: Get.height * 0.03,
              ),
              if (bottomController.currentRole.toString() == "Provider") ...[
                Obx(() {
                  if (controller.selectedIndex.value == 0) {
                    return RequestServicesWidget(status: "new", role: bottomController.currentRole.toString(),);
                  } else if (controller.selectedIndex.value == 1) {
                    return RequestServicesWidget(status: "active", role: bottomController.currentRole.toString(),);
                  } else {
                    return RequestServicesWidget(status: "complete", role: bottomController.currentRole.toString(),);
                  }
                }),
              ],
              if (bottomController.currentRole.toString() == "Customer") ...[
                Obx(() {
                  if (controller.selectedIndex.value == 0) {
                    // return ListView.separated(
                    //   itemCount: 5,
                    //   shrinkWrap: true,
                    //   physics: const ScrollPhysics(),
                    //   itemBuilder: (itemBuilder, index) {
                    //     return const CustomerRequestsContainer(
                    //       status: "2m",
                    //       imagePath: [
                    //         AppImage.profile,
                    //         AppImage.profile,
                    //         AppImage.profile
                    //       ],
                    //       imageLabel: '+10 Proposals',
                    //     );
                    //   },
                    //   separatorBuilder: (BuildContext context, int index) {
                    //     return SizedBox(
                    //       height: Get.height * 0.03,
                    //     );
                    //   },
                    // );
                    return RequestServicesWidget(status: "new", role: bottomController.currentRole.toString(),);
                  } else if (controller.selectedIndex.value == 1) {
                    return RequestServicesWidget(status: "active", role: bottomController.currentRole.toString(),);
                    // return ListView.separated(
                    //   itemCount: 5,
                    //   shrinkWrap: true,
                    //   physics: const ScrollPhysics(),
                    //   itemBuilder: (itemBuilder, index) {
                    //     return const CustomerRequestsContainer(
                    //       status: "Active",
                    //       imagePath: [
                    //         AppImage.profile,
                    //       ],
                    //       imageLabel: 'EltWhid Software Engineering',
                    //     );
                    //   },
                    //   separatorBuilder: (BuildContext context, int index) {
                    //     return SizedBox(
                    //       height: Get.height * 0.03,
                    //     );
                    //   },
                    // );
                  } else {
                    return RequestServicesWidget(status: "complete", role: bottomController.currentRole.toString(),);
                  }
                }),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
