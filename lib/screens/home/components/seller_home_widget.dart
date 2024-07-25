import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../constant/CollectionUtils/collection_utils.dart';
import '../../../constant/datetime/date_time_util.dart';
import '../../../constant/res/app_color/app_color.dart';
import '../../../constant/res/app_images/app_images.dart';
import '../../../services/request/request_services.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_loading.dart';
import '../../../widgets/custom_stream_builder.dart';
import '../../../widgets/device_widget.dart';
import '../../../widgets/dialog_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../device/publish_device.dart';
import '../../store/store_detail.dart';
class SellerHomeWidget extends StatelessWidget {
  const SellerHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidget(
            title: "Choose your service and start",
            textColor: AppColor.semiTransparentDarkGrey,
            fontSize: 16),
        SizedBox(
          height: Get.height * 0.05,
        ),
        MyCustomButton(
            iconPath: AppImage.service,
            textColor: AppColor.primaryColor,
            borderSideColor: AppColor.primaryColor,
            title: "Publish a device".tr,
            backgroundColor: Colors.transparent,
            onTap: () {
              Get.to(const PublishDevice(
                isUpdate: false,
              ));
            }),
        SizedBox(
          height: Get.height * 0.02,
        ),
         TextWidget(
          title: "My devices".tr,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          textColor: AppColor.semiDarkGrey,
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        CustomStreamBuilder(
          stream: QueryUtil.fetchDevices(),
          builder: (context, devices) {
            log("Devices length is ${devices!.length}");
            return GridView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.4,
                ),
                itemCount: devices.length,
                itemBuilder: (itemBuilder, index) {
                  final data = devices[index];
                  return DeviceWidget(
                      date: DateTimeUtil.reformatDate(
                          data.timestamp.toString()),
                      onClick: () {
                        Get.to(StoreDetail(
                          showChatIcon: false,
                          deviceModel: data,
                        ));
                      },
                      deviceName: data.deviceName,
                      deviceModel: data.deviceModel,
                      onDeleteTap: () {
                        Get.dialog(DialogWidget(
                            title: "Delete Device",
                            description:
                            "Are you sure you want to delete device?",
                            mainButtonText: "Delete",
                            mainButtonTap: () async {
                              await RequestServices
                                  .deleteDevice(data.id);
                              Get.back();
                            }));
                      },
                      onEditTap: () {
                        Get.to(PublishDevice(
                          isUpdate: true,
                          deviceModel: data,
                        ));
                      },
                      imageUrl: data.deviceImage);
                });
          },
          loadingWidget: Column(
            children: [
              SizedBox(
                height: Get.height * 0.2,
              ),
              const CustomLoading(),
            ],
          ),
        )
      ],
    );
  }
}
