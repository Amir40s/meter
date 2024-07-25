import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meter/screens/chat/chat_detail.dart';
import 'package:provider/provider.dart';

import '../../../constant/CollectionUtils/collection_utils.dart';
import '../../../constant/datetime/date_time_util.dart';
import '../../../constant/res/app_color/app_color.dart';
import '../../../constant/res/app_images/app_images.dart';
import '../../../controller/account/profile_controller.dart';
import '../../../controller/bottomNav/bottom_nav_controller_main.dart';
import '../../../controller/home/home_controller.dart';
import '../../../controller/onboard/onboard_controller.dart';
import '../../../controller/store_controller/store_controller.dart';
import '../../../model/devices/devices_model.dart';
import '../../../provider/chat/chat_provider.dart';
import '../../../widgets/categoriesWidget.dart';
import '../../../widgets/circular_container.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_loading.dart';
import '../../../widgets/custom_stream_builder.dart';
import '../../../widgets/servicesWidget.dart';
import '../../../widgets/text_widget.dart';
import '../../cServices/services_screen.dart';
import '../../chat/chat_screen.dart';
import '../../requestServices/request_services_screen.dart';
import '../../store/store_detail.dart';

class CustomerHomeWidget extends StatelessWidget {
  const CustomerHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final onBoardController = Get.find<OnBoardController>();
    final controller = Get.find<HomeController>();
    final storeController = Get.put(StoreController());
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          stream: QueryUtil.fetchDevicesForStore(),
          builder: (context, devices) {
            return Obx(() {
              List<DeviceModel> filteredDevices = [];
              if (storeController.deviceSearch.value.isEmpty ||
                  storeController.deviceSearch.value == "") {
                filteredDevices = devices!;
              } else {
                final lowerCaseSearch =
                storeController.deviceSearch.value.toLowerCase();

                filteredDevices = devices!.where((device) {
                  final lowerCaseDeviceName =
                  device.deviceName.toLowerCase();
                  final lowerCaseModel =
                  device.deviceModel.toLowerCase();
                  int relevanceScore = 0;

                  // Condition 1: Exact match
                  if (lowerCaseDeviceName == lowerCaseSearch) {
                    relevanceScore +=
                    3; // Assign a higher score for an exact match
                  }

                  // Condition 2: Contains the search term
                  if (lowerCaseDeviceName.contains(lowerCaseSearch) ||
                      lowerCaseModel.contains(lowerCaseSearch)) {
                    relevanceScore +=
                    1; // Assign a lower score for partial match
                  }

                  return relevanceScore > 0;
                }).toList();
              }
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
                  itemCount: filteredDevices.length,
                  itemBuilder: (itemBuilder, index) {
                    final data = filteredDevices[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(StoreDetail(
                          deviceModel: data,
                        ));
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                AppImage.person,
                                width: 30,
                              ),
                              const Spacer(),
                              TextWidget(
                                  title: DateTimeUtil.reformatDate(
                                      data.timestamp.toString()),
                                  textColor:
                                  AppColor.semiTransparentDarkGrey,
                                  fontSize: 12),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Image.network(
                            data.deviceImage,
                            fit: BoxFit.cover,
                            width: Get.width,
                            height: Get.height * 0.3,
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 14.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                        title: data.deviceName,
                                        textColor:
                                        AppColor.semiDarkGrey,
                                        fontSize: 12),
                                    TextWidget(
                                        title: data.deviceModel,
                                        textColor: AppColor
                                            .semiTransparentDarkGrey,
                                        fontSize: 8),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              CircularContainer(
                                onTap: () async{
                                  final chatRoomId = await context.read<ChatProvider>().createOrGetChatRoom(data.userUID,"");
                                  log("Id in home screen::${data.id} and ${data.userUID}");
                                  Get.to(ChatDetail(
                                    userUID: data.userUID,
                                    name: data.deviceName,
                                    image: data.deviceImage,
                                    otherEmail: data.userUID,
                                    chatRoomId: chatRoomId,
                                  ));
                                  // Get.to(ChatDetail());
                                  // Get.find<BottomNavController>()
                                  //     .currentIndex
                                  //     .value = 3;
                                },
                                imageSize: 24,
                                imagePath: AppImage.chatActive,
                                backgroundColor:
                                AppColor.lightGreyShade,
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  });
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
        // if (controller.currentRole.value == "Customer") ...[
        //
        // ],
      ],
    );
  }
}
