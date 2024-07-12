import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/services/user/user_services.dart';
import 'package:meter/widgets/categoriesWidget.dart';
import 'package:meter/widgets/custom_rich_text.dart';
import 'package:meter/widgets/servicesWidget.dart';

import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../controller/bottomNav/bottom_nav_controller_main.dart';
import '../../controller/home/home_controller.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/text_widget.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
   // final onBoardController = Get.put(OnBoardController());
    final controller = Get.put(HomeController());
    return SafeArea(
      child: Scaffold(
        appBar: CustomHomeAppBar(
          title: "Makka,Saudi Arabia".tr,
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.01,
                ),
               CustomRichText(firstText: "Good Morning", secondText: 'secondText', press: (){}),

                SizedBox(
                  height: Get.height * 0.01,
                ),
                Obx(() {
                  if (controller.currentRole.value == "Seller") {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextWidget(
                            title: "Choose your service and start",
                            textColor: AppColor.semiTransparentDarkGrey,
                            fontSize: 16),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        MyCustomButton(
                            iconPath: AppImage.service,
                            textColor: AppColor.primaryColor,
                            borderSideColor: AppColor.primaryColor,
                            title: "Publish a device".tr,
                            backgroundColor: Colors.transparent,
                            onTap: () {
                              // Get.to(const PublishDevice(
                              //   isUpdate: false,
                              // ));
                            }),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        const TextWidget(
                          title: "My Devices",
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          textColor: AppColor.semiDarkGrey,
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        // CustomStreamBuilder(
                        //   stream: QueryUtil.fetchDevices(),
                        //   builder: (context, devices) {
                        //     log("Devices length is ${devices!.length}");
                        //     return GridView.builder(
                        //         shrinkWrap: true,
                        //         physics: const ScrollPhysics(),
                        //         gridDelegate:
                        //         const SliverGridDelegateWithFixedCrossAxisCount(
                        //           crossAxisCount: 2, // Number of columns
                        //           crossAxisSpacing: 8.0,
                        //           mainAxisSpacing: 8.0,
                        //           childAspectRatio: 0.4,
                        //         ),
                        //         itemCount: devices.length,
                        //         itemBuilder: (itemBuilder, index) {
                        //           final data = devices[index];
                        //           return EditDeviceWidget(
                        //               date: DateTimeUtil.reformatDate(
                        //                   data.timestamp.toString()),
                        //               onClick: () {
                        //                 // Get.to(StoreDetail(
                        //                 //   showChatIcon: false,
                        //                 //   deviceModel: data,
                        //                 // ));
                        //               },
                        //               deviceName: data.deviceName,
                        //               deviceModel: data.deviceModel,
                        //               onDeleteTap: () {
                        //                 // Get.dialog(LogoutDialogue(
                        //                 //     title: "Delete Device",
                        //                 //     description:
                        //                 //     "Are you sure you want to delete device?",
                        //                 //     mainButtonText: "Delete",
                        //                 //     mainButtonTap: () async {
                        //                 //       await DbServices.deleteDevice(
                        //                 //           data.id);
                        //                 //       Get.back();
                        //                 //     }));
                        //               },
                        //               onEditTap: () {
                        //                 // Get.to(PublishDevice(
                        //                 //   isUpdate: true,
                        //                 //   deviceModel: data,
                        //                 // ));
                        //               },
                        //               imageUrl: data.deviceImage);
                        //         });
                        //   },
                        //   loadingWidget: Column(
                        //     children: [
                        //       SizedBox(
                        //         height: Get.height * 0.2,
                        //       ),
                        //       const CustomLoading(),
                        //     ],
                        //   ),
                        // )
                      ],
                    );
                  }
                  else if (controller.currentRole.value == "Provider") {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextWidget(
                            title:
                            "There are a lot of requests waiting for you",
                            textColor: AppColor.semiTransparentDarkGrey,
                            fontSize: 14),
                        CustomTextField(
                          controller: controller.searchController,
                          hintText: "Search",
                          title: "",
                          showSpace: true,
                          prefixImagePath: AppImage.search,
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        const TextWidget(
                          title: "Requests Near You",
                          textColor: AppColor.semiDarkGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        // ListView.separated(
                        //   shrinkWrap: true,
                        //   physics: const ScrollPhysics(),
                        //   itemCount: 5,
                        //   itemBuilder: (itemBuilder, index) {
                        //     return const RequestContainer(
                        //       buttonText: "Apply Now",
                        //     );
                        //   },
                        //   separatorBuilder: (BuildContext context, int index) {
                        //     return SizedBox(
                        //       height: Get.height * 0.02,
                        //     );
                        //   },
                        // )
                      ],
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.currentRole.value == "Customer") ...[
                          const TextWidget(
                              title: "Choose your service and start",
                              textColor: AppColor.semiTransparentDarkGrey,
                              fontSize: 16),
                          SizedBox(
                            height: Get.height * 0.04,
                          ),
                          MyCustomButton(
                              iconPath: AppImage.service,
                              textColor: AppColor.primaryColor,
                              borderSideColor: AppColor.primaryColor,
                              title: "Request a service".tr,
                              backgroundColor: Colors.transparent,
                              onTap: () {
                               // Get.to(const RequestService());
                              }),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          const TextWidget(
                            title: "Categories",
                            textColor: AppColor.semiDarkGrey,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          SizedBox(
                            height: Get.height * 0.19,
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 6,
                              padding: EdgeInsets.zero,
                              itemBuilder: (itemBuilder, index) {
                                return const CategoriesWidget(
                                    imagePath: AppImage.surveyOffices,
                                    title: "Survey Offices");
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  width: Get.width * 0.03,
                                );
                              },
                            ),
                          ),
                          const Row(
                            children: [
                              TextWidget(
                                title: "Services",
                                textColor: AppColor.semiDarkGrey,
                                fontSize: 18,
                              ),
                              Spacer(),
                              TextWidget(
                                title: "See All",
                                textColor: AppColor.primaryColor,
                                fontSize: 14,
                                showUnderline: true,
                              )
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          GridView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                childAspectRatio: 1.08,
                              ),
                              itemCount: controller.imaPath.length,
                              itemBuilder: (itemBuilder, index) {
                                return ServicesWidget(
                                    onTap: (){
                                      // Get.to(SurveyReport(
                                      //   title: onBoardController.title[index],
                                      //   description:
                                      //   onBoardController.description[index],
                                      //   benefitList: onBoardController.benefitList[index],
                                      //   imagePath: onBoardController.imagePath[index],
                                      // ));
                                    },
                                    title: controller.title[index],
                                    imagePath: controller.imaPath[index]);
                              }),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Row(
                            children: [
                              const TextWidget(
                                  title: "Explore Products",
                                  textColor: AppColor.semiDarkGrey,
                                  fontSize: 18),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Get.find<BottomNavController>()
                                      .onIndexChange(1);
                                },
                                child: const TextWidget(
                                    title: "See All",
                                    textColor: AppColor.primaryColor,
                                    showUnderline: true,
                                    fontSize: 17),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          GridView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns
                                crossAxisSpacing: 12.0,
                                mainAxisSpacing: 12.0,
                                childAspectRatio: 0.7,
                              ),
                              itemCount: 10,
                              itemBuilder: (itemBuilder, index) {
                                return Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                          BorderRadius.circular(12)),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            AppImage.productImage,
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.01,
                                          ),
                                          const TextWidget(
                                            title: "Electrical Machine",
                                            textColor: AppColor.semiDarkGrey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800,
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.01,
                                          ),
                                          const Row(
                                            children: [
                                              TextWidget(
                                                title: "3.4",
                                                textColor:
                                                AppColor.semiDarkGrey,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800,
                                              ),
                                              Spacer(),
                                              TextWidget(
                                                  title: "302 SAR",
                                                  textColor:
                                                  AppColor.primaryColor,
                                                  fontSize: 14)
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: AppColor.primaryColor,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(12),
                                          bottomLeft: Radius.circular(12),
                                        ),
                                      ),
                                      child: const TextWidget(
                                        textColor: AppColor.whiteColor,
                                        title: "25 %",
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ],
                      ],
                    );
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
