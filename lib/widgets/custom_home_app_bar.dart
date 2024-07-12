import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/widgets/text_widget.dart';

import '../constant/res/app_color/app_color.dart';
import '../constant/res/app_images/app_images.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final String title;
  final List<Widget>? actions;

  const CustomHomeAppBar(
      {super.key, this.leading, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Padding(
        padding: EdgeInsets.only(left: 14.0),
        child: CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage(AppImage.profile),
        ),
      ),
      title: Row(
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
