// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:meter_app/controller/bottom_nav_controller/store_controller/store_controller.dart';
// import 'package:meter_app/res/app_color/app_color.dart';
// import 'package:meter_app/res/app_assets/app_image.dart';
// import 'package:meter_app/utils/backend_util/date_time_util.dart';
// import 'package:meter_app/utils/backend_util/query_util.dart';
// import 'package:meter_app/view/bottom_nav/chat/chat_detail.dart';
// import 'package:meter_app/view/bottom_nav/store/store_detail.dart';
// import 'package:meter_app/widget/containers/circular_container.dart';
// import 'package:meter_app/widget/custom_loading.dart';
// import 'package:meter_app/widget/text_widget.dart';
// import 'package:meter_app/widget/textfield.dart';
//
// import '../../../model/seller/device/device_model.dart';
// import '../../../widget/backend/custom_stream_builder.dart';
// import '../../constant/res/app_color/app_color.dart';
// import '../../constant/res/app_images/app_images.dart';
// import '../../widgets/custom_loading.dart';
// import '../../widgets/text_widget.dart';
//
// class StoreMain extends StatelessWidget {
//   const StoreMain({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(StoreController());
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.all(14.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: Get.height * 0.02,
//                 ),
//                 const Align(
//                   alignment: Alignment.topCenter,
//                   child: TextWidget(
//                     title: "Meter Store",
//                     textColor: AppColor.semiDarkGrey,
//                     fontSize: 16,
//                   ),
//                 ),
//                 CustomTextField(
//                     prefixImagePath: AppImage.search,
//                     hintText: "Search",
//                     title: "",
//                     controller: controller.searchController),
//                 SizedBox(
//                   height: Get.height * 0.02,
//                 ),
//                 CustomStreamBuilder(
//                   stream: QueryUtil.fetchDevicesForStore(),
//                   builder: (context, devices) {
//                     return Obx(() {
//                       List<DeviceModel> filteredDevices = [];
//                       if (controller.deviceSearch.value.isEmpty ||
//                           controller.deviceSearch.value == "") {
//                         filteredDevices = devices!;
//                       } else {
//                         final lowerCaseSearch =
//                         controller.deviceSearch.value.toLowerCase();
//
//                         filteredDevices = devices!.where((device) {
//                           final lowerCaseDeviceName =
//                           device.deviceName.toLowerCase();
//                           final lowerCaseModel =
//                           device.deviceModel.toLowerCase();
//                           int relevanceScore = 0;
//
//                           // Condition 1: Exact match
//                           if (lowerCaseDeviceName == lowerCaseSearch) {
//                             relevanceScore +=
//                             3; // Assign a higher score for an exact match
//                           }
//
//                           // Condition 2: Contains the search term
//                           if (lowerCaseDeviceName.contains(lowerCaseSearch) ||
//                               lowerCaseModel.contains(lowerCaseSearch)) {
//                             relevanceScore +=
//                             1; // Assign a lower score for partial match
//                           }
//
//                           return relevanceScore > 0;
//                         }).toList();
//                       }
//                       return GridView.builder(
//                           shrinkWrap: true,
//                           physics: const ScrollPhysics(),
//                           gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2, // Number of columns
//                             crossAxisSpacing: 8.0,
//                             mainAxisSpacing: 8.0,
//                             childAspectRatio: 0.4,
//                           ),
//                           itemCount: filteredDevices.length,
//                           itemBuilder: (itemBuilder, index) {
//                             final data = filteredDevices[index];
//                             return GestureDetector(
//                               onTap: () {
//                                 Get.to(StoreDetail(
//                                   deviceModel: data,
//                                 ));
//                               },
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Image.asset(
//                                         AppImage.person,
//                                         width: 30,
//                                       ),
//                                       const Spacer(),
//                                       TextWidget(
//                                           title: DateTimeUtil.reformatDate(
//                                               data.timestamp.toString()),
//                                           textColor:
//                                           AppColor.semiTransparentDarkGrey,
//                                           fontSize: 12),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: Get.height * 0.01,
//                                   ),
//                                   Image.network(
//                                     data.deviceImage,
//                                     fit: BoxFit.contain,
//                                     height: Get.height * 0.3,
//                                   ),
//                                   SizedBox(
//                                     height: Get.height * 0.01,
//                                   ),
//                                   Row(
//                                     children: [
//                                       Padding(
//                                         padding:
//                                         const EdgeInsets.only(left: 14.0),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           children: [
//                                             TextWidget(
//                                                 title: data.deviceName,
//                                                 textColor:
//                                                 AppColor.semiDarkGrey,
//                                                 fontSize: 12),
//                                             TextWidget(
//                                                 title: data.deviceModel,
//                                                 textColor: AppColor
//                                                     .semiTransparentDarkGrey,
//                                                 fontSize: 8),
//                                           ],
//                                         ),
//                                       ),
//                                       const Spacer(),
//                                       CircularContainer(
//                                         onTap: () {
//                                           Get.to(ChatDetail());
//                                           // Get.find<BottomNavController>()
//                                           //     .currentIndex
//                                           //     .value = 3;
//                                         },
//                                         imageSize: 24,
//                                         imagePath: AppImage.chatActive,
//                                         backgroundColor:
//                                         AppColor.lightGreyShade,
//                                       )
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             );
//                           });
//                     });
//                   },
//                   loadingWidget: Column(
//                     children: [
//                       SizedBox(
//                         height: Get.height * 0.2,
//                       ),
//                       const CustomLoading(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
