import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant/routes/routes_name.dart';

import '../../constant.dart';
import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../controller/auth/main_auth_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/text_widget.dart';


class ServicesScreen extends StatelessWidget {
  final String title;
  final String description;
  final List benefitList;
  final String imagePath;
  const ServicesScreen(
      {super.key,
        required this.title,
        required this.description,
        required this.benefitList,
        required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainAuthController());
    log(getCurrentUid().toString());
    return SafeArea(
        child: Scaffold(
          bottomNavigationBar: Container(
              height: Get.height * 0.12,
              margin:
              EdgeInsets.only(bottom: Get.height * 0.02, left: 14, right: 14),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Expanded(
                      child: MyCustomButton(
                        onTap: () {
                          if(getCurrentUid().toString().isNotEmpty){
                            Get.offAllNamed(RoutesName.requestServicesScreen);
                          }else{
                            controller.switchToNewRole(customer);
                            controller.changeActive(false);
                            Get.offAllNamed(RoutesName.mainLoginSignupScreen);
                          }

                        },
                        fontSize: 14,
                        padding: 10,
                        title: "Survey Reports",
                        borderSideColor: AppColor.primaryColor,
                        backgroundColor: Colors.transparent,
                        textColor: AppColor.primaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: MyCustomButton(
                        onTap: () async {
                          if(getCurrentUid().toString().isNotEmpty){
                            Get.offAllNamed(RoutesName.requestServicesScreen);
                          }else{
                            controller.switchToNewRole(provider);
                            controller.changeActive(false);
                            log("message: ${controller.selectedLogin}");
                            Get.offAllNamed(RoutesName.mainLoginSignupScreen,arguments: "old");
                          }
                        },
                        fontSize: 14,
                        padding: 10,
                        title: "Provide Service".tr,
                        borderSideColor: AppColor.primaryColor,
                        backgroundColor: Colors.transparent,
                        textColor: AppColor.primaryColor,
                      ),
                    ),
                  ],
                ),
              )),
          body: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomHeader(title: title),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Image.asset(
                      imagePath,
                      height: Get.height * 0.07,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.0, right: 2.0),
                    child: TextWidget(
                      title: title,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      textColor: AppColor.semiDarkGrey,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14.0, right: 14),
                child: TextWidget(
                  title: description,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextWidget(
                      title: "Benefits:",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      textColor: AppColor.semiDarkGrey,
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: ScrollPhysics(),
                        itemCount: benefitList.length,
                        itemBuilder: (itemBuilder, index) {
                          return TextWidget(
                            title: benefitList[index],
                            textColor: AppColor.primaryColor,
                            textAlign: TextAlign.start,
                          );
                        }),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    const TextWidget(
                      title: "Service Providers",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      textColor: AppColor.semiDarkGrey,
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    ListView.separated(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (itemBuilder, index) {
                        return Row(children: [
                          const CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage(AppImage.profile3),
                          ),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const TextWidget(
                                    title: "David Wayne",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    textColor: AppColor.semiDarkGrey,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Image.asset(
                                    AppImage.fiveStar,
                                    width: Get.height * 0.09,
                                  ),
                                ],
                              ),
                              const TextWidget(
                                title: "Engineering Office",
                              ),
                            ],
                          ),
                        ]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: Get.height * 0.03,
                        );
                      },
                    )
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
