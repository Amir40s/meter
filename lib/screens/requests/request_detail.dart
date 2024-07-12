import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../controller/services/request_controller.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/text_widget.dart';

class RequestDetail extends StatelessWidget {
  const RequestDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RequestController());
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const CustomHeader(title: "Request Detail"),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Row(
                      children: [
                        // Leading image
                        Image.asset(
                          AppImage.pdf, // Replace with your AppImage.pdf path
                          width: 40,
                        ),
                        SizedBox(
                            width: Get.width *
                                0.05), // Space between leading image and text column
                        // Title and Subtitle
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                title: "Survey report.pdf",
                                fontWeight: FontWeight.bold,
                                textColor: AppColor.semiDarkGrey,
                              ),
                              SizedBox(
                                  height:
                                      4), // Space between title and subtitle
                              TextWidget(
                                title: "318 kb. 31 Aug,2022",
                                fontSize: 12,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                            width:
                                10), // Space between text column and trailing image
                        // Trailing image
                        Image.asset(
                          AppImage
                              .download, // Replace with your AppImage.download path
                          width: 24,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (itemBuilder, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              title: controller.titles[index],
                            ),
                            TextWidget(
                              title: controller.values[index],
                              fontWeight: FontWeight.bold,
                            )
                          ],
                        );
                      },
                      separatorBuilder: (separatorBuilder, index) {
                        return const Divider(
                          color: AppColor.semiTransparentDarkGrey,
                        );
                      },
                      itemCount: controller.titles.length),
                  Divider(
                    color: AppColor.semiTransparentDarkGrey,
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          title: "Grand Total",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          textColor: AppColor.semiDarkGrey,
                        ),
                        TextWidget(
                          title: "\$175.25",
                          textColor: AppColor.primaryColor,
                        )
                      ])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
