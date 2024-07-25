import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/widgets/text_widget.dart';

import '../constant/res/app_color/app_color.dart';
import '../constant/res/app_images/app_images.dart';
import '../controller/account/profile_controller.dart';
import '../controller/bottomNav/bottom_nav_controller_main.dart';


class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final String title,imageUrl;
  final List<Widget>? actions;

  const CustomHomeAppBar(
      {super.key, this.leading, required this.title, this.actions, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    String role = profileController.user.value.role.toString();
    return AppBar(
      leading:  GestureDetector(
        onTap: (){
          if(role == "Seller"){
            Get.find<BottomNavController>()
                .currentIndex
                .value = 3;
          }else{
            Get.find<BottomNavController>()
                .currentIndex
                .value = 4;
          }

        },
        child: Container(
          margin: EdgeInsets.only(left: 10.0,right: 10),
          child: CircleAvatar(
            radius: 18,
            backgroundImage: imageUrl.isNotEmpty ?  NetworkImage(imageUrl) : const AssetImage(AppImage.profile),
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: Get.height * 0.01,
          ),
          Image.asset(
            AppImage.activeLocation,
            width: 18,
          ),
          const SizedBox(
            width: 5,
          ),
          TextWidget(
              title: title, textColor: AppColor.semiDarkGrey, fontSize: 16),
          const SizedBox(
            width: 3,
          ),
          Image.asset(
            AppImage.downArrow,
            width: 18,
          ),
        ],
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
                onPressed: () {},
                icon: Image.asset(
                  AppImage.notification,
                  width: 24,
                )),
            Positioned(
              bottom: Get.width * 0.10,
              right: 10,
              child: const CircleAvatar(
                radius: 4,
                backgroundColor: AppColor.primaryColor,
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
