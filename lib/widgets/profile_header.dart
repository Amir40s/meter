import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/widgets/text_widget.dart';

import '../constant/res/app_color/app_color.dart';
import '../constant/res/app_images/app_images.dart';
import '../screens/account/edit_user_info.dart';
import 'circular_container.dart';

class ProfileHeader extends StatelessWidget {
  final bool showPersonalInfo;
  const ProfileHeader({super.key, this.showPersonalInfo = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: const CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage(AppImage.profile),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Transform.translate(
              offset: Offset(showPersonalInfo ? -Get.width * 0.06 : 3, 0),
              child: const TextWidget(
                  title: "Thomas k.Wilson",
                  textColor: AppColor.primaryColor,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 2,
            ),
            showPersonalInfo
                ? Transform.translate(
                    offset: Offset(-Get.width * 0.06, 0),
                    child: twoWidget(
                        imagePath: AppImage.call, text: "(+966)  20 1234 5629"),
                  )
                : Container(),
            showPersonalInfo
                ? twoWidget(
                    imagePath: AppImage.mail, text: "thomas.abc.inc@gmail.com")
                : Container(),
          ],
        ),
        const Spacer(),
        CircularContainer(
            imageSize: 24,
            imagePath: AppImage.pen,
            onTap: () {
              Get.bottomSheet(
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  const EditUserInfo(),
                  backgroundColor: AppColor.whiteColor);
            })
      ],
    );
  }

  Widget twoWidget({required imagePath, required text}) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          width: 18,
        ),
        const SizedBox(
          width: 5,
        ),
        TextWidget(title: text, textColor: AppColor.semiDarkGrey, fontSize: 12)
      ],
    );
  }
}
