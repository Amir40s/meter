import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant.dart';
import 'package:meter/constant/routes/routes_name.dart';
import 'package:meter/model/requestServices/request_services_model.dart';
import 'package:meter/widgets/image_loader_widget.dart';
import 'package:meter/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import '../constant/res/app_color/app_color.dart';
import '../constant/res/app_images/app_images.dart';
import '../provider/chat/chat_provider.dart';
import '../screens/chat/chat_detail.dart';
import 'circular_container.dart';
import 'custom_button.dart';

class RatingContainer extends StatelessWidget {
  final String ownerName,details,price,url,status,requestId,proposalId;
  RatingContainer({super.key, required this.ownerName, required this.details, required this.price, required this.url, required this.status, required this.requestId, required this.proposalId,});


  final TextEditingController controller  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.transparent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.translate(
            offset: Offset(-12, 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Container(
                              width: 50.0,
                              height: 50.0,
                              child: ImageLoaderWidget(imageUrl: url,))),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                            textAlign: TextAlign.start,
                            title:ownerName,
                            textColor: AppColor.semiDarkGrey,
                            fontSize: 16),
                        TextWidget(
                            title: "Engineering Office",
                            textColor: AppColor.semiTransparentDarkGrey,
                            fontSize: 15)
                      ],
                    ),
                    Transform.translate(
                      offset: Offset(-30, -11),
                      child: Image.asset(
                        AppImage.rating,
                        height: 14,
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircularContainer(
                        backgroundColor: AppColor.success10,
                        imagePath: AppImage.chatActive,
                        onTap: () async{
                          // final chatRoomId = await context.read<ChatProvider>().createOrGetChatRoom(data.userUID,"");
                          // final userStatus = await context.read<ChatProvider>().getUserStatus(chatRoomId);
                          // log("Id in home screen::${data.id} and ${mo.userUID}");
                          // Get.to(ChatDetail(
                          //   userUID: data.userUID,
                          //   name: data.deviceName,
                          //   image: data.deviceImage,
                          //   otherEmail: data.userUID,
                          //   chatRoomId: chatRoomId,
                          //   userStatus: userStatus,
                          // ));
                        },
                      ),
                      CircularContainer(
                        backgroundColor: AppColor.primaryColor,
                        widget:  TextWidget(
                          textColor: AppColor.whiteColor,
                          title: "\n$price\nSAR\n",
                          fontSize: 14,
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
          TextWidget(
              textAlign: TextAlign.start,
              title:
              details,
              textColor: AppColor.semiTransparentDarkGrey,
              fontSize: 12),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Row(
            children: [
              Expanded(
                  child: MyCustomButton(
                    title: "Decline",
                    onTap: () {
                      if(status == "new"){
                        changeStatus(status: "reject");
                      }

                    },
                    textColor: AppColor.primaryColor,
                    backgroundColor: AppColor.whiteColor,
                    borderSideColor: AppColor.primaryColor,
                  )),
              SizedBox(
                width: Get.width * 0.02,
              ),
              Expanded(
                child: CustomButton(title: status == "new" ?
                "Accept" :  status == "reject" ? "Rejected" : "Accepted", onTap: () async{
                  if(status == "new"){
                    changeStatus(status: "active");
                  }
                }),
              )
            ],
          )
        ],
      ),
    );
  }

  void changeStatus({required String status}) async{
    log("Status::$status");
    await firestore.collection("requestService").doc(requestId).update({
      "status" : status
    });

    await firestore.collection("requestService").doc(requestId)
        .collection("proposals").doc(proposalId)
        .update({
      "status" : status
    });
    Get.snackbar("Alert", "Status Updated");

    if(status == "active"){
      Get.toNamed(RoutesName.paymentScreen,arguments: {
        'price' : price.toString()
      });
    }
  }
}
