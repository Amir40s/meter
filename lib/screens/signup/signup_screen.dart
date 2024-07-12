import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/screens/signup/provider/provider_main.dart';
import 'package:meter/screens/signup/seller/seller_signup_screen.dart';
import 'package:meter/widgets/box_widget.dart';
import '../../constant.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../controller/auth/main_auth_controller.dart';
import 'customer/customer_main.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainAuthController>();
    return Obx(() => Column(
      children: [
        SizedBox(
          height: Get.height * 0.02,
        ),
        Row(
          children: [
            BoxWidget(
              onTap: () {
                controller.switchToNewRole(seller);
              },
              imagePath: AppImage.sellerPerson,
              title: seller.tr,
              isActive: controller.selectedRole.value == seller,
              activeImagePath: AppImage.sellerPersonActive,
            ),
            SizedBox(
              width: Get.width * 0.02,
            ),
            BoxWidget(
              onTap: () {
                controller.switchToNewRole(customer);
              },
              imagePath: AppImage.customerPerson,
              title: customer.tr,
              isActive: controller.selectedRole.value == customer,
              activeImagePath: AppImage.customerPersonActive,
            ),
            SizedBox(
              width: Get.width * 0.02,
            ),
            BoxWidget(
              onTap: () {
                controller.switchToNewRole(provider);
              },
              imagePath: AppImage.providedPerson,
              title: provider.tr,
              isActive: controller.selectedRole.value == provider,
              activeImagePath: AppImage.providedPersonActive,
            ),
          ],
        ),
        if (controller.selectedRole.value == seller)
          const SellerSignupScreen(),
        if (controller.selectedRole.value == customer)
          const CustomerLoginMain(),
        if (controller.selectedRole.value == provider)
          const ProviderLoginMain(),
      ],
    ));
  }
}
