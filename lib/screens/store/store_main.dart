import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/screens/store/store_detail.dart';
import 'package:provider/provider.dart';

import '../../constant/CollectionUtils/collection_utils.dart';
import '../../constant/datetime/date_time_util.dart';
import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../controller/store_controller/store_controller.dart';
import '../../model/devices/devices_model.dart';
import '../../provider/chat/chat_provider.dart';
import '../../widgets/circular_container.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/custom_stream_builder.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/text_widget.dart';
import '../chat/chat_detail.dart';
import '../chat/chat_screen.dart';

class StoreMain extends StatelessWidget {
  const StoreMain({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StoreController());
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.02,
                ),
                const Align(
                  alignment: Alignment.topCenter,
                  child: TextWidget(
                    title: "Meter Store",
                    textColor: AppColor.semiDarkGrey,
                    fontSize: 16,
                  ),
                ),
                CustomTextField(
                    prefixImagePath: AppImage.search,
                    hintText: "Search",
                    title: "",
                    onChanged: (newValue) {
                      controller.onChangeSearch(newValue);
                      log("New Value is $newValue");
                    },
                    controller: controller.searchController),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                CustomStreamBuilder(
                  stream: QueryUtil.fetchDevicesForStore(),
                  builder: (context, devices) {
                    return Obx(() {
                      List<DeviceModel> filteredDevices = [];
                      if (controller.deviceSearch.value.isEmpty ||
                          controller.deviceSearch.value == "") {
                        filteredDevices = devices!;
                      } else {
                        final lowerCaseSearch =
                        controller.deviceSearch.value.toLowerCase();

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
                                          final userStatus = await context.read<ChatProvider>().getUserStatus(chatRoomId);
                                          log("Id in home screen::${data.id} and ${data.userUID}");
                                          Get.to(ChatDetail(
                                            userUID: data.userUID,
                                            name: data.deviceName,
                                            image: data.deviceImage,
                                            otherEmail: data.userUID,
                                            chatRoomId: chatRoomId,
                                            userStatus: userStatus,
                                          ));
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
