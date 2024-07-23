import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meter/screens/home/home_screen.dart';

import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../controller/bottomNav/bottom_nav_controller_main.dart';
import '../account/account_main.dart';
import '../chat/chat_main.dart';
import '../device/devices.dart';
import '../requests/requests_main.dart';
import '../store/store_main.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavController = Get.find<BottomNavController>();
    return SafeArea(
        child: Scaffold(
      body: Obx(() {
        String role = bottomNavController.currentRole.value;
        bool isSeller = role == "Seller";
        log("why role is $role");
        List<Widget> children = [
          HomeScreen(),
          if (!isSeller) const StoreMain(),
          if (isSeller) const AllDevices(),
          if (!isSeller) const RequestsMain(),
          // HomeScreen(),
          // HomeScreen(),
          // HomeScreen()
          const ChatMain(),
          AccountMain(),
        ];

        return children[bottomNavController.currentIndex.value];
      }),
      bottomNavigationBar: Obx(() {
        String role = bottomNavController.currentRole.value;
        bool isSeller = role == "Seller";
        bool isProvider = role == "Provider";

        List<BottomNavigationBarItem> items = [
          BottomNavigationBarItem(
            icon: Image.asset(
              AppImage.home,
              width: 22,
              height: 22,
            ),
            activeIcon: Image.asset(
              AppImage.homeActive,
              width: 24,
              height: 24,
            ),
            label: "Home".tr,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              AppImage.store,
              width: 22,
              height: 22,
            ),
            activeIcon: Image.asset(
              AppImage.storeActive,
              width: 24,
              height: 24,
            ),
            label: !isSeller ? "Store".tr : "My devices",
          ),
          if (!isSeller)
            BottomNavigationBarItem(
              icon: Image.asset(
                AppImage.requests,
                width: 22,
                height: 22,
              ),
              activeIcon: Image.asset(
                AppImage.requestsActive,
                width: 24,
                height: 24,
              ),
              label: isProvider ? "Proposals".tr : "Requests".tr,
            ),
          BottomNavigationBarItem(
            icon: Image.asset(
              AppImage.chat,
              width: 22,
              height: 22,
            ),
            activeIcon: Image.asset(
              AppImage.chatActive,
              width: 24,
              height: 24,
            ),
            label: "Chat".tr,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              AppImage.account,
              width: 22,
              height: 22,
            ),
            activeIcon: Image.asset(
              AppImage.accountActive,
              width: 24,
              height: 24,
            ),
            label: "Account".tr,
          ),
        ];

        return BottomNavigationBar(
          elevation: 0,
          items: items,
          showUnselectedLabels: true,
          backgroundColor: Colors.transparent,
          // selectedFontSize: 10,
          currentIndex: bottomNavController.currentIndex.value,
          selectedItemColor: AppColor.primaryColor,
          unselectedItemColor: AppColor.semiTransparentDarkGrey,
          iconSize: 18,
          selectedLabelStyle: GoogleFonts.poppins(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
          onTap: (index) {
            bottomNavController.onIndexChange(index);
          },
        );
      }),
    ));
  }
}
