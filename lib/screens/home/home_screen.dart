import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant.dart';
import 'package:meter/constant/location/location_utils.dart';
import 'package:meter/controller/account/profile_controller.dart';
import 'package:meter/controller/onboard/onboard_controller.dart';
import 'package:meter/model/requestServices/request_services_model.dart';
import 'package:meter/screens/cServices/services_screen.dart';
import 'package:meter/screens/requestServices/request_services_screen.dart';
import 'package:meter/services/request/request_services.dart';
import 'package:meter/widgets/categoriesWidget.dart';
import 'package:meter/widgets/custom_rich_text.dart';
import 'package:meter/widgets/device_widget.dart';
import 'package:meter/widgets/dialog_widget.dart';
import 'package:meter/widgets/request_widget.dart';
import 'package:meter/widgets/servicesWidget.dart';
import '../../constant/CollectionUtils/collection_utils.dart';
import '../../constant/datetime/date_time_util.dart';
import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../controller/bottomNav/bottom_nav_controller_main.dart';
import '../../controller/home/home_controller.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/custom_stream_builder.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/text_widget.dart';
import '../device/publish_device.dart';
import '../store/store_detail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onBoardController = Get.find<OnBoardController>();
    final controller = Get.find<HomeController>();
    final profileController = Get.find<ProfileController>();
    log("Rebuild again");
    return SafeArea(
      child: Scaffold(
        appBar: CustomHomeAppBar(
          title: profileController.user.value.city,
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
                Obx(() => CustomRichText(
                      firstText: getGreeting(),
                      secondText: "${profileController.user.value.ownerName}!",
                      press: () {},
                      firstTextFontWeight: FontWeight.w600,
                      firstSize: 20,
                      secondSize: 20,
                      secondTextFontWeight: FontWeight.bold,
                      firstTextColor: AppColor.semiDarkGrey,
                    )),
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
                              Get.to(const PublishDevice(
                                isUpdate: false,
                              ));
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
                        CustomStreamBuilder(
                          stream: QueryUtil.fetchDevices(),
                          builder: (context, devices) {
                            log("Devices length is ${devices!.length}");
                            return GridView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Number of columns
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                  childAspectRatio: 0.4,
                                ),
                                itemCount: devices.length,
                                itemBuilder: (itemBuilder, index) {
                                  final data = devices[index];
                                  return DeviceWidget(
                                      date: DateTimeUtil.reformatDate(
                                          data.timestamp.toString()),
                                      onClick: () {
                                        Get.to(StoreDetail(
                                          showChatIcon: false,
                                          deviceModel: data,
                                        ));
                                      },
                                      deviceName: data.deviceName,
                                      deviceModel: data.deviceModel,
                                      onDeleteTap: () {
                                        Get.dialog(DialogWidget(
                                            title: "Delete Device",
                                            description:
                                                "Are you sure you want to delete device?",
                                            mainButtonText: "Delete",
                                            mainButtonTap: () async {
                                              await RequestServices
                                                  .deleteDevice(data.id);
                                              Get.back();
                                            }));
                                      },
                                      onEditTap: () {
                                        // Get.to(PublishDevice(
                                        //   isUpdate: true,
                                        //   deviceModel: data,
                                        // ));
                                      },
                                      imageUrl: data.deviceImage);
                                });
                          },
                          loadingWidget: Column(
                            children: [
                              SizedBox(
                                height: Get.height * 0.2,
                              ),
                              const CustomLoading(),
                            ],
                          ),
                        )
                      ],
                    );
                  } else if (controller.currentRole.value == "Provider") {
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
                          onChanged: (newValue) {
                            controller.onChangeRequestSearch(newValue);
                            log("New Value is $newValue");
                          },
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
                        CustomStreamBuilder(
                          stream: QueryUtil.fetchRequestServices(),
                          builder: (context, requests) {
                            return Obx(() {
                              List<RequestServicesModel> filteredRequests = [];
                              if (controller.requestSearch.value.isEmpty ||
                                  controller.requestSearch.value == "") {
                                filteredRequests = requests!;
                              } else {
                                final lowerCaseSearch = controller
                                    .requestSearch.value
                                    .toLowerCase();

                                filteredRequests = requests!.where((request) {
                                  final lowerCaseActivityType =
                                      request.activityType.toLowerCase();
                                  final lowerCaseDetails =
                                      request.details.toLowerCase();

                                  int relevanceScore = 0;

                                  // Condition 1: Exact match
                                  if (lowerCaseActivityType ==
                                      lowerCaseSearch) {
                                    relevanceScore +=
                                        3; // Assign a higher score for an exact match
                                  }

                                  // Condition 2: Contains the search term
                                  if (lowerCaseActivityType
                                          .contains(lowerCaseSearch) ||
                                      lowerCaseDetails
                                          .contains(lowerCaseSearch)) {
                                    relevanceScore +=
                                        1; // Assign a lower score for partial match
                                  }

                                  return relevanceScore > 0;
                                }).toList();
                              }
                              if (filteredRequests.isEmpty) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: Get.height * 0.2,
                                    ),
                                    const Center(
                                      child: TextWidget(
                                        title: "No data found",
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColor.semiDarkGrey,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                );
                              }
                              return ListView.separated(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: filteredRequests.length,
                                itemBuilder: (itemBuilder, index) {
                                  final data = filteredRequests[index];
                                  String longitude = data.long;
                                  String latitude = data.lat;
                                  double distance = LocationUtils.getDistance(
                                      latitude, longitude);
                                  log("Distance is $distance");
                                  return RequestWidget(
                                    buttonText: "Apply Now",
                                    time: LocationUtils.getDistanceFormatted(
                                        latitude, longitude),
                                    profileImage: data.userProfileImage,
                                    location: data.location,
                                    description: data.details,
                                    title: data.activityType,
                                    onTap: () {},
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: Get.height * 0.02,
                                  );
                                },
                              );
                            });
                          },
                          loadingWidget: Column(
                            children: [
                              SizedBox(
                                height: Get.height * 0.2,
                              ),
                              const CustomLoading(),
                            ],
                          ),
                        ),
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
                                Get.to(const RequestServicesScreen());
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
                                    onTap: () {
                                      Get.to(ServicesScreen(
                                        title: onBoardController.title[index],
                                        description: onBoardController
                                            .description[index],
                                        benefitList: onBoardController
                                            .benefitList[index],
                                        imagePath:
                                            onBoardController.imagePath[index],
                                      ));
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
                          CustomStreamBuilder(
                            stream: QueryUtil.fetchDevices(),
                            builder: (context, devices) {
                              log("Devices length is ${devices!.length}");
                              return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, // Number of columns
                                    crossAxisSpacing: 8.0,
                                    mainAxisSpacing: 8.0,
                                    childAspectRatio: 0.4,
                                  ),
                                  itemCount: devices.length,
                                  itemBuilder: (itemBuilder, index) {
                                    final data = devices[index];
                                    return Stack(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(StoreDetail(
                                              showChatIcon: true,
                                              deviceModel: data,
                                            ));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Column(
                                              children: [
                                                Image.network(
                                                  data.deviceImage,
                                                  fit: BoxFit.contain,
                                                  width: Get.width,
                                                  height: Get.height * 0.3,
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,
                                                ),
                                                TextWidget(
                                                  title: data.deviceName,
                                                  textColor:
                                                      AppColor.semiDarkGrey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,
                                                ),
                                                Row(
                                                  children: [
                                                    TextWidget(
                                                      title: data.rating
                                                          .toStringAsFixed(2),
                                                      textColor:
                                                          AppColor.semiDarkGrey,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                    const Spacer(),
                                                    TextWidget(
                                                        title:
                                                            "${data.devicePrice} SAR",
                                                        textColor: AppColor
                                                            .primaryColor,
                                                        fontSize: 14)
                                                  ],
                                                )
                                              ],
                                            ),
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
                                  });
                            },
                            loadingWidget: Column(
                              children: [
                                SizedBox(
                                  height: Get.height * 0.2,
                                ),
                                const CustomLoading(),
                              ],
                            ),
                          ),
                          // GridView.builder(
                          //     shrinkWrap: true,
                          //     physics: const ScrollPhysics(),
                          //     gridDelegate:
                          //         const SliverGridDelegateWithFixedCrossAxisCount(
                          //       crossAxisCount: 2, // Number of columns
                          //       crossAxisSpacing: 12.0,
                          //       mainAxisSpacing: 12.0,
                          //       childAspectRatio: 0.7,
                          //     ),
                          //     itemCount: 10,
                          //     itemBuilder: (itemBuilder, index) {
                          //       return Stack(
                          //         children: [
                          //           Container(
                          //             decoration: BoxDecoration(
                          //                 color: Colors.transparent,
                          //                 borderRadius:
                          //                     BorderRadius.circular(12)),
                          //             child: Column(
                          //               children: [
                          //                 Image.asset(
                          //                   AppImage.productImage,
                          //                 ),
                          //                 SizedBox(
                          //                   height: Get.height * 0.01,
                          //                 ),
                          //                 const TextWidget(
                          //                   title: "Electrical Machine",
                          //                   textColor: AppColor.semiDarkGrey,
                          //                   fontSize: 14,
                          //                   fontWeight: FontWeight.w800,
                          //                 ),
                          //                 SizedBox(
                          //                   height: Get.height * 0.01,
                          //                 ),
                          //                 const Row(
                          //                   children: [
                          //                     TextWidget(
                          //                       title: "3.4",
                          //                       textColor:
                          //                           AppColor.semiDarkGrey,
                          //                       fontSize: 12,
                          //                       fontWeight: FontWeight.w800,
                          //                     ),
                          //                     Spacer(),
                          //                     TextWidget(
                          //                         title: "302 SAR",
                          //                         textColor:
                          //                             AppColor.primaryColor,
                          //                         fontSize: 14)
                          //                   ],
                          //                 )
                          //               ],
                          //             ),
                          //           ),
                          //           Container(
                          //             padding: const EdgeInsets.all(4),
                          //             decoration: const BoxDecoration(
                          //               color: AppColor.primaryColor,
                          //               borderRadius: BorderRadius.only(
                          //                 topRight: Radius.circular(12),
                          //                 bottomLeft: Radius.circular(12),
                          //               ),
                          //             ),
                          //             child: const TextWidget(
                          //               textColor: AppColor.whiteColor,
                          //               title: "25 %",
                          //               fontSize: 14,
                          //             ),
                          //           ),
                          //         ],
                          //       );
                          //     }),
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
