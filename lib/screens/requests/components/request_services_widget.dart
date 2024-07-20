import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meter/constant/res/app_color/app_color.dart';
import 'package:provider/provider.dart';

import '../../../constant/res/app_images/app_images.dart';
import '../../../model/requestServices/request_services_model.dart';
import '../../../provider/firebase_services.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/proposal_container.dart';
import '../request_info.dart';
class RequestServicesWidget extends StatelessWidget {
  final String status,role;
  bool isWorkButton;
   RequestServicesWidget({super.key, required this.status,
  this.isWorkButton = false, required this.role
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseServicesProvider>(
      builder: (context, provider, child){
        return StreamBuilder<List<RequestServicesModel>>(
          stream: provider.getRequestServicesFilter(status: status),
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
              itemCount: requestModel.length,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (itemBuilder, index) {
                RequestServicesModel model = requestModel[index];
                log("message ${model.phoneNumber}");
                return  ProposalContainer(
                  status: status,
                  imagePath: model.proposalCount > 3 ? model.proposals.toList() : model.proposals.take(3).toList(),
                  imageLabel: ' ${model.proposalCount > 10 ? "+" : ""}${model.proposalCount.toString()} Proposals ',
                  date: model.currentDate,
                  applicationName: model.activityType, location: model.location,
                  model: model, role: role,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: Get.height * 0.03,
                );
              },
            );
          },
        );
      },
    );
  }
}
