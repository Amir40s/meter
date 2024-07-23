import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../../constant/res/app_color/app_color.dart';
import '../../../constant/res/app_images/app_images.dart';
import '../../../controller/home/home_controller.dart';
import '../../../model/requestServices/request_services_model.dart';
import '../../../provider/firebase_services.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/request_widget.dart';
import '../../../widgets/text_widget.dart';

class ProviderHomeWidget extends StatelessWidget {
  const ProviderHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidget(
            title:
            "There are a lot of requests waiting for you",
            textColor: AppColor.semiTransparentDarkGrey,
            fontSize: 14),
        CustomTextField(
          controller: controller.searchController,
          hintText: "Search",
          onChanged: (newValue) {
            controller.onChangeRequestSearch(newValue);
            log("New Value is $newValue");
          },
          title: "",
          showSpace: true,
          prefixImagePath: AppImage.search,
        ),
        SizedBox(
          height: Get.height * 0.03,
        ),
        const TextWidget(
          title: "Requests Near You",
          textColor: AppColor.semiDarkGrey,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Consumer<FirebaseServicesProvider>(
          builder: (context, provider, child){
            return StreamBuilder<List<RequestServicesModel>>(
              stream: provider.getRequestServices(),
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: AppColor.primaryColor,));
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No request found'));
                }

                List<RequestServicesModel> requestModel = snapshot.data!;
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: requestModel.length,
                  itemBuilder: (itemBuilder, index) {
                    RequestServicesModel model = requestModel[index];
                    return  RequestWidget(
                      buttonText: "Apply Now", activityType: model.activityType, model: model,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: Get.height * 0.02,
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
