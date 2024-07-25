import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant.dart';
import 'package:meter/constant/location/location_utils.dart';
import 'package:meter/controller/account/profile_controller.dart';
import 'package:meter/controller/onboard/onboard_controller.dart';
import 'package:meter/model/requestServices/request_services_model.dart';
import 'package:meter/screens/cServices/services_screen.dart';
import 'package:meter/screens/home/components/customer_home_widget.dart';
import 'package:meter/screens/home/components/provider_home_widget.dart';
import 'package:meter/screens/home/components/seller_home_widget.dart';
import 'package:meter/screens/requestServices/request_services_screen.dart';
import 'package:meter/services/request/request_services.dart';
import 'package:meter/widgets/categoriesWidget.dart';
import 'package:meter/widgets/custom_rich_text.dart';
import 'package:meter/widgets/device_widget.dart';
import 'package:meter/widgets/dialog_widget.dart';
import 'package:meter/widgets/request_widget.dart';
import 'package:meter/widgets/servicesWidget.dart';
import 'package:provider/provider.dart';
import '../../constant/CollectionUtils/collection_utils.dart';
import '../../constant/datetime/date_time_util.dart';
import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../controller/bottomNav/bottom_nav_controller_main.dart';
import '../../controller/home/home_controller.dart';
import '../../controller/store_controller/store_controller.dart';
import '../../model/devices/devices_model.dart';
import '../../provider/chat/chat_provider.dart';
import '../../provider/firebase_services.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/circular_container.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/custom_stream_builder.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/text_widget.dart';
import '../chat/chat_screen.dart';
import '../device/publish_device.dart';
import '../store/store_detail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final profileController = Get.find<ProfileController>();
    final userModel = profileController.user;

    // Ensuring the role is correctly set before building the UI
    String role = profileController.user.value.role ?? '';
    log("Role on HomeScreen: $role");
    log("Rebuild again");
    return SafeArea(
      child: Scaffold(
        appBar: CustomHomeAppBar(
          title: profileController.user.value.city,
          imageUrl: userModel.value.profilePicture.toString(),
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
                  switch (controller.currentRole.value) {
                    case "Seller":
                      return const SellerHomeWidget();
                    case "Provider":
                      return const ProviderHomeWidget();
                    default:
                      return const CustomerHomeWidget();
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
