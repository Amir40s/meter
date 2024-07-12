import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constant/language/language_utils.dart';
import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../controller/chat/chat_controller_main.dart';
import '../../widgets/chat_popup.dart';
import '../../widgets/chat_text_field.dart';
import '../../widgets/circular_container.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/pop_up_manu_widget.dart';
import '../../widgets/text_widget.dart';

class ChatDetail extends StatelessWidget {
  const ChatDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatControllerMain());
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomBackButton(),
                  TextWidget(
                      title: "Message",
                      textColor: AppColor.semiDarkGrey,
                      fontSize: 16),
                  const ChatPopupMenu()
                ],
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(AppImage.profile),
                  ),
                  SizedBox(
                    width: Get.width * 0.09,
                  ),
                  TextWidget(
                      title: "Moge",
                      textColor: AppColor.semiDarkGrey,
                      fontSize: 16)
                ],
              ),
              Expanded(
                flex: 8,
                child: ListView.builder(
                    itemCount: controller.messages.length,
                    shrinkWrap: true,
                    itemBuilder: (itemBuilder, index) {
                      final message = controller.messages[index];
                      final isMe = message["isMe"];
                      final content = message["content"];
                      final dateTime = message["dateTime"];
                      bool isEnglish = LanguageUtils.isEnglishLang();
                      return Align(
                        alignment: isMe
                            ? (isEnglish
                                ? Alignment.centerRight
                                : Alignment.centerLeft)
                            : (isEnglish
                                ? Alignment.centerLeft
                                : Alignment.centerRight),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: isMe
                                ? (isEnglish ? 20 : 0)
                                : (isEnglish ? 0 : 20),
                            right: isMe
                                ? (isEnglish ? 0 : 20)
                                : (isEnglish ? 20 : 0),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 19, vertical: 8),
                            decoration: isMe
                                ? BoxDecoration(
                                    color: AppColor.primaryColor,
                                    borderRadius: BorderRadius.circular(12),
                                  )
                                : null,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextWidget(
                                  textAlign: TextAlign.left,
                                  title: content,
                                  textColor: isMe
                                      ? AppColor.whiteColor
                                      : AppColor.semiDarkGrey,
                                  fontSize: 14,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                TextWidget(
                                  title: DateFormat('hh:mm').format(dateTime),
                                  textColor: isMe
                                      ? AppColor.whiteColor
                                      : AppColor.semiTransparentDarkGrey,
                                  fontSize: 12,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    PopupMenuButton<String>(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        offset: Offset(0, -Get.height * 0.32),
                        // position: PopU,
                        icon: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.success10,
                          ),
                          child: Image.asset(
                            AppImage.add,
                          ),
                        ),
                        iconSize: 40,
                        onSelected: (String value) {
                          print("You selected $value");
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuWidget(
                              height: Get.height * 0.4,
                              child: ChatAddBottomSheet(),
                            ),
                          ];
                        }),
                    // CircularContainer(
                    //     imagePath: AppImage.add,
                    //     backgroundColor: AppColor.success10,
                    //     onTap: () {
                    //       Get.bottomSheet(
                    //           shape: const RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.only(
                    //               topLeft: Radius.circular(20),
                    //               topRight: Radius.circular(20),
                    //             ),
                    //           ),
                    //           const ChatAddBottomSheet(),
                    //           backgroundColor: AppColor.whiteColor);
                    //     }),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    Expanded(
                        child: ChatTextField(hintText: "Type a message...".tr)),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    CircularContainer(imagePath: AppImage.send, onTap: () {}),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
