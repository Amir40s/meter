import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant/routes/routes_name.dart';
import 'package:meter/screens/cServices/services_screen.dart';
import 'package:meter/widgets/servicesWidget.dart';

import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../controller/onboard/onboard_controller.dart';
import '../../widgets/custom_rich_text.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/text_widget.dart';

class OnboardWelcomeScreen extends StatelessWidget {
  const OnboardWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnBoardController>();
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
                child: GridView.builder(
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
                      return GestureDetector(
                        onTap: () {
                          Get.offAllNamed(RoutesName.mainLoginSignupScreen);
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(12)),
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
                                        textColor: AppColor.semiDarkGrey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                      ),
                                      Spacer(),
                                      TextWidget(
                                          title: "302 SAR",
                                          textColor: AppColor.primaryColor,
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
                        ),
                      );
                    }),
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
