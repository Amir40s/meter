import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/bottomSheet/profile/edit_profile_bottomsheet.dart';
import 'package:meter/controller/account/profile_controller.dart';
import 'package:meter/model/user/user_model.dart';
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
    final controller = Get.find<ProfileController>();
    final userModel = controller.user;
    return Row(
      children: [
        Obx(() => Container(
              margin: EdgeInsets.only(right: 5.0),
              child: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(userModel.value.profilePicture),
              ),
            )),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => TextWidget(
                  title: userModel.value.ownerName,
                  textColor: AppColor.primaryColor,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 2,
            ),
            Obx(() => showPersonalInfo
                ? twoWidget(
                    imagePath: AppImage.call, text: userModel.value.phoneNumber)
                : Container()),
            Obx(
              () => showPersonalInfo
                  ? twoWidget(
                      imagePath: AppImage.mail, text: userModel.value.email)
                  : Container(),
            )
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
                  const EditProfileBottomSheet(),
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
