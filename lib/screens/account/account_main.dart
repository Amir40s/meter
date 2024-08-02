import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant/routes/routes_name.dart';
import 'package:meter/model/user/user_model.dart';
import 'package:meter/screens/account/pivacy_policy.dart';
import 'package:meter/screens/account/terms_of_service.dart';
import 'package:meter/widgets/custom_loading.dart';
import 'package:meter/widgets/dialog_widget.dart';
import '../../constant/prefUtils/pref_utils.dart';
import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../controller/account/profile_controller.dart';
import '../../controller/bottomNav/bottom_nav_controller_main.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_row.dart';
import '../../widgets/profile_header.dart';
import '../../widgets/text_widget.dart';
import 'help_center.dart';

class AccountMain extends StatelessWidget {
  const AccountMain({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    final BottomNavController bottomNavController =
        Get.find<BottomNavController>();
    final String currentRole = bottomNavController.currentRole.value;
    UserModel userModel = controller.user.value;
    log("User is ${userModel.email}");
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.whiteColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: SizedBox(
                width: Get.width,
                height: Get.height * 0.84,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Row(
                         // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomBackButton(
                              onTap: () {
                                Get.find<BottomNavController>()
                                    .currentIndex
                                    .value = 0;
                              },
                            ),
                            const Spacer(),
                            // SizedBox(
                            //   width: Get.width * 0.04,
                            // ),
                            TextWidget(
                              title: "Profile".tr,
                              textColor: AppColor.semiDarkGrey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            const Spacer(),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        ProfileHeader(
                          showPersonalInfo: currentRole == "Seller" ||
                              currentRole == "Customer" || currentRole == "Provider" ,
                          currentRole: currentRole,
                        ),
                        if (currentRole == "Provider") ...[
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          MyCustomButton(
                              backgroundColor: AppColor.primaryShade,
                              textColor: AppColor.primaryColor,
                              iconPath: AppImage.autoCard,
                              title: "Go To AutoCard".tr,
                              onTap: () {})
                        ],
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        currentRole == "Provider" || currentRole == "Customer" || currentRole == "Seller"
                            ? CustomRow(
                                firstImagePath: AppImage.paymentMethod,
                                title: "Payment Methods".tr,
                                onTap: () {},
                              )
                            : Container(),
                        currentRole == "Provider" || currentRole == "Customer" || currentRole == "Seller"
                            ? CustomRow(
                                firstImagePath: AppImage.help,
                                title: "Help Center".tr,
                                onTap: () {
                                  Get.to(const HelpCenter());
                                },
                              )
                            : Container(),
                        CustomRow(
                          dropDownItems: const ["English", "ﻋَﺮَﺑِﻲّ"],
                          selectedLanguage: controller.selectedLanguage.value,
                          onLanguageChanged: (newValue) {
                            controller.changeSelectedLanguage(newValue);
                          },
                          title: "Language".tr,
                          onTap: () {},
                        ),
                        // currentRole == "Provider" || currentRole == "Customer"
                        //     ? CustomRow(
                        //         title: "Help Center".tr,
                        //         onTap: () {
                        //           Get.to(const HelpCenter());
                        //         },
                        //       )
                        //     : Container(),
                        CustomRow(
                          title: "Terms Of Services".tr,
                          onTap: () {
                            Get.to(const TermsOfService());
                          },
                        ),
                        CustomRow(
                          title: "Privacy Policy".tr,
                          onTap: () {
                            Get.to(const PrivacyPolicy());
                          },
                        ),
                        CustomRow(
                          title: "About App".tr,
                          onTap: () {},
                        ),
                        CustomRow(
                          textColor: AppColor.primaryColor,
                          title: "Delete Account".tr,
                          onTap: () {
                            Get.dialog(Obx(() => controller
                                    .deleteAccountLoading.value
                                ? const CustomLoading()
                                : DialogWidget(
                                    title: "Delete",
                                    description:
                                        "Are you sure you want to delete account?",
                                    mainButtonText: "Delete",
                                    mainButtonTap: () {
                                      controller.deleteAccount();
                                    })));
                            // Get.bottomSheet()
                          },
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      child: SizedBox(
                        width: Get.width * 0.90,
                        child: MyCustomButton(
                          title: "Logout".tr,
                          onTap: () {
                            Get.dialog(DialogWidget(
                                title: "Logout".tr,
                                description: "Are you sure to logout?".tr,
                                mainButtonText: "Logout".tr,
                                mainButtonTap: () async{
                                 await PrefUtil.remove(PrefUtil.userId);
                                  Get.offAllNamed(
                                      RoutesName.mainLoginSignupScreen);
                                }));
                          },
                          textColor: AppColor.primaryColor,
                          backgroundColor: AppColor.primaryShade,
                          iconPath: AppImage.logout,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
