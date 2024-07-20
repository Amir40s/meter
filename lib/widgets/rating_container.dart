import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant.dart';
import 'package:meter/constant/routes/routes_name.dart';
import 'package:meter/model/requestServices/request_services_model.dart';
import 'package:meter/widgets/image_loader_widget.dart';
import 'package:meter/widgets/text_widget.dart';
import '../constant/res/app_color/app_color.dart';
import '../constant/res/app_images/app_images.dart';
import '../screens/chat/chat_detail.dart';
import 'circular_container.dart';
import 'custom_button.dart';

class RatingContainer extends StatelessWidget {
  final String ownerName,details,price,url,status,requestId,proposalId;
  const RatingContainer({super.key, required this.ownerName, required this.details, required this.price, required this.url, required this.status, required this.requestId, required this.proposalId,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.transparent),
      child: Column(
        children: [
          Transform.translate(
            offset: Offset(-12, 3),
            child: Row(
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
                  offset: Offset(-9, -9),
                  child: Image.asset(
                    AppImage.rating,
                    height: 14,
                  ),
                ),
                CircularContainer(
                  backgroundColor: AppColor.success10,
                  imagePath: AppImage.chatActive,
                  onTap: () {
                    Get.to(ChatDetail());
                  },
                ),
                CircularContainer(
                  backgroundColor: AppColor.primaryColor,
                  widget:  TextWidget(
                    textColor: AppColor.whiteColor,
                    title: "\n$price\nSAR\n",
                    fontSize: 16,
                  ),
                  onTap: () {},
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
      Get.toNamed(RoutesName.paymentScreen);
    }
  }
}
