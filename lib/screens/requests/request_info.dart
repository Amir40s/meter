import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/model/requestServices/request_services_model.dart';

import '../../constant.dart';
import '../../constant/res/app_color/app_color.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/customer_request_widget.dart';
import '../../widgets/rating_container.dart';

class RequestInfo extends StatelessWidget {
  final RequestServicesModel model;
  const RequestInfo({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const CustomHeader(title: "Request Info"),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomerRequestsContainer(
                      status: convertTimestamp(model.timestamp.toString()),
                      showAvatar: false, model: model,
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    RichText(
                      text: TextSpan(
                        style: AppTextStyle.dark14.copyWith(
                            color: AppColor.semiDarkGrey, fontSize: 18),
                        children: [
                          TextSpan(text: 'Proposals'.tr),
                          TextSpan(
                            text:"(${ model.proposalCount.toString()})".tr,
                            style: AppTextStyle.dark14.copyWith(
                                color: AppColor.primaryColor, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, -18),
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: model.proposals.length,
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (itemBuilder, index) {
                            return RatingContainer(
                              ownerName: model.proposals[index].ownerName,
                              details: model.proposals[index].details,
                              price: model.proposals[index].price,
                              url: model.proposals[index].profileImage,
                              status:  model.proposals[index].status,
                              requestId: model.id,
                              proposalId: model.proposals[index].id,

                            );
                          }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
