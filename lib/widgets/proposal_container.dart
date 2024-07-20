import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant.dart';
import 'package:meter/model/requestServices/request_services_model.dart';
import 'package:meter/model/requestServices/send_request_model.dart';
import 'package:meter/widgets/image_loader_widget.dart';
import 'package:meter/widgets/text_widget.dart';
import 'package:meter/widgets/timestamp_converter.dart';

import '../constant/res/app_color/app_color.dart';
import '../constant/res/app_images/app_images.dart';
import '../screens/requests/request_info.dart';
import '../screens/send_work/send_work_main.dart';
import 'avatar_list.dart';
import 'custom_button.dart';

class ProposalContainer extends StatelessWidget {
  final String status,applicationName,location;
  final String date,details;
  final List<SendRequestModel> imagePath;
  final RequestServicesModel model;
  final String imageLabel,role;


   ProposalContainer(
      {super.key,
      required this.status,
      required this.imagePath,
      required this.imageLabel,
        required this.date,
        required this.applicationName,
        required this.location,
        required this.model,
        required this.role,
         this.details = "",
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColor.lightGreyShade),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                 TextWidget(
                    title: date,
                    textColor: AppColor.primaryColor,
                    fontSize: 14),
                const Spacer(),

                if(role == "Customer")...[
                  TextWidget(
                      title: status == "active" ? "Active" : convertTimestamp(model.timestamp.toString()),
                      textColor: status == "active" ?  AppColor.greenColor:AppColor.primaryColor,
                      fontSize: 14),
                ]else...[
                  TextWidget(
                      title: status,
                      textColor: status == "new"
                          ? AppColor.primaryColor
                          : status == "active"
                          ? AppColor.greenColor
                          : AppColor.semiDarkGrey,
                      fontSize: 12)
                ]

              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 CircleAvatar(
                  radius: 26,
                  backgroundColor: AppColor.primaryColor,
                  // backgroundImage: AssetImage(AppImage.dummySketch),
                  child: Container(
                      width: 50.0,
                      height: 50.0,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: ImageLoaderWidget(imageUrl: model.userProfileImage.toString()))),
                ),
                SizedBox(
                  width: Get.width * 0.02,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     TextWidget(
                      title: applicationName,
                      textColor: AppColor.semiDarkGrey,
                      fontSize: 18,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          AppImage.activeLocation,
                          width: 18,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                         TextWidget(
                          textColor: AppColor.semiTransparentDarkGrey,
                          fontSize: 14,
                          textOverflow: TextOverflow.ellipsis,
                          title: location ?? "",
                                                 ),
                      ],
                    )
                  ],
                )
              ],
            ),
            if(details.isNotEmpty)...[
              SizedBox(
                height: Get.height * 0.03,
              ),
              TextWidget(
                  title: details,
                  textColor: Colors.black,
                  textAlign: TextAlign.start,
                  fontSize: 14),
            ],
            SizedBox(
              height: Get.height * 0.03,
            ),
            Row(
              children: [
                AvatarModelList(imagePaths: imagePath),
                SizedBox(
                  width: Get.width * 0.05,
                ),
                TextWidget(
                    title: imageLabel,
                    textColor: AppColor.semiTransparentDarkGrey,
                    fontSize: 12),
              ],
            ),
            if(role == provider)
            SizedBox(
              height: Get.height * 0.04,
            ),
            if (status == "active") ...[
              if(role == provider)
              SizedBox(
                height: Get.height * 0.02,
              ),
              if(role == provider)
              MyCustomButton(
                title: "Send Work",
                onTap: () {
                  // Get.to(DeliveringServiceMain());
                  Get.to(const SendWork());
                  // Get.to(ConsolationDeliveryMain());
                },
                textColor: AppColor.primaryColor,
                backgroundColor: Colors.transparent,
                borderSideColor: AppColor.primaryColor,
                padding: 12,
              )
            ]else...[
              SizedBox(height: 10.0,),
              MyCustomButton(
                padding: 12,
                title: "View All Proposal",
                onTap: () {
                  Get.to(RequestInfo(
                      model: model
                  ));
                },
                borderSideColor: AppColor.primaryColor,
                textColor: AppColor.primaryColor,
                backgroundColor: AppColor.lightGreyShade,
              )
            ]
          ],
        ),
      ),
    );
  }
}
