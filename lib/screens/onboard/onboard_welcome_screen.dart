import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant/routes/routes_name.dart';
import 'package:meter/screens/cServices/services_screen.dart';
import 'package:meter/widgets/servicesWidget.dart';
import 'package:provider/provider.dart';

import '../../constant/CollectionUtils/collection_utils.dart';
import '../../constant/datetime/date_time_util.dart';
import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../controller/onboard/onboard_controller.dart';
import '../../controller/store_controller/store_controller.dart';
import '../../model/devices/devices_model.dart';
import '../../provider/chat/chat_provider.dart';
import '../../widgets/circular_container.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/custom_rich_text.dart';
import '../../widgets/custom_stream_builder.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/text_widget.dart';
import '../store/store_detail.dart';

class OnboardWelcomeScreen extends StatelessWidget {
  const OnboardWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnBoardController>();
    final storeController = Get.put(StoreController());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.04,
                      ),
                      const TextWidget(
                        title: "Welcome in",
                        fontSize: 28,
                        textAlign: TextAlign.start,
                        textColor: AppColor.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                      Transform.translate(
                        offset: Offset(0, -Get.height * 0.015),
                        child: const TextWidget(
                          title: "Meter👋🏻",
                          fontSize: 28,
                          textAlign: TextAlign.start,
                          textColor: AppColor.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      //Explore Services - take your life to next level
                      CustomRichText(
                        firstText: "Explore Services - ",
                        firstTextColor: AppColor.whiteColor,
                        secondTextColor: AppColor.whiteColor,
                        secondSize: 14,
                        secondText: "take your life to next level",
                        press: () {},
                        firstSize: 16,
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      CustomTextField(
                          prefixImagePath: AppImage.searchActive,
                          hintText: "Search",
                          showSpace: true,
                          fillColor: AppColor.whiteColor,
                          title: "",
                          controller: TextEditingController()),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Expanded(
                        child: imageAndText(
                            AppImage.service, "Request a service")),
                    SizedBox(width: Get.width * 0.02),
                    Expanded(
                        child: imageAndText(
                            AppImage.provideService, "Provide service")),
                    SizedBox(width: Get.width * 0.02),
                    Expanded(
                        child: imageAndText(
                            AppImage.storeActive, "Devices displaying")),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(AppImage.construction)),
                    Image.asset(AppImage.play),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 14.0, right: 14),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: TextWidget(
                    title: "Services Providers",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    textColor: AppColor.semiDarkGrey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Expanded(child: imageAndStar(AppImage.profile1)),
                    SizedBox(width: Get.width * 0.04),
                    Expanded(child: imageAndStar(AppImage.profile2)),
                    SizedBox(width: Get.width * 0.04),
                    Expanded(child: imageAndStar(AppImage.profile3)),
                    SizedBox(width: Get.width * 0.04),
                    Expanded(child: imageAndStar(AppImage.profile4)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    const TextWidget(
                      title: "Services",
                      textColor: AppColor.semiDarkGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed(RoutesName.mainLoginSignupScreen);
                      },
                      child: const TextWidget(
                        title: "See All",
                        textColor: AppColor.primaryColor,
                        fontSize: 14,
                        showUnderline: true,
                      ),
                    )
                  ],
                ),
              ),
              // SizedBox(
              //   height: Get.height * 0.02,
              // ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1.08,
                    ),
                    itemCount: controller.imagePath.length,
                    itemBuilder: (itemBuilder, index) {
                      return ServicesWidget(
                          onTap: () {
                            Get.to(ServicesScreen(
                              title: controller.title[index],
                              description: controller.description[index],
                              benefitList: controller.benefitList[index],
                              imagePath: controller.imagePath[index],
                            ));
                            // Get.offAll(const MainAuth());
                          },
                          title: controller.title[index],
                          imagePath: controller.imagePath[index]);
                    }),
              ),
              // SizedBox(
              //   height: Get.height * 0.02,
              // ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    const TextWidget(
                        title: "Explore Products",
                        textColor: AppColor.semiDarkGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed(RoutesName.mainLoginSignupScreen);
                      },
                      child: const TextWidget(
                          title: "See All",
                          textColor: AppColor.primaryColor,
                          showUnderline: true,
                          fontSize: 17),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: Get.height * 0.03,
              // ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: CustomStreamBuilder(
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
                                Get.offAllNamed(RoutesName.mainLoginSignupScreen);
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
                                    fit: BoxFit.contain,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget imageAndText(String imagePath, String title) {
  return GestureDetector(
    onTap: () {
      Get.offAllNamed(RoutesName.mainLoginSignupScreen);
    },
    child: Container(
      height: Get.height * 0.1355,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColor.primaryColor)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            height: Get.height * 0.037,
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          TextWidget(
              title: title,
              textColor: AppColor.primaryColor,
              textAlign: TextAlign.start,
              fontSize: 14),
        ],
      ),
    ),
  );
}

Widget imageAndStar(String profilePath) {
  return InkWell(
    onTap: () {
      Get.offAllNamed(RoutesName.mainLoginSignupScreen);
    },
    child: Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(
            profilePath,
          ),
          radius: 40,
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Image.asset(
          AppImage.fiveStar,
          width: Get.height * 0.15,
        ),
      ],
    ),
  );
}
