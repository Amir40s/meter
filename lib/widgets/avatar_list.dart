import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/requestServices/send_request_model.dart';
import 'image_loader_widget.dart';

class AvatarList extends StatelessWidget {
  final List<String> imagePaths;
  const AvatarList({super.key, required this.imagePaths});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.05,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imagePaths.length < 4 ? imagePaths.length : 4,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Align(
            widthFactor: 0.3,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(imagePaths[index]),
            ),
          );
        },
      ),
    );
  }
}

class AvatarModelList extends StatelessWidget {
  final List<SendRequestModel> imagePaths;
  const AvatarModelList({super.key, required this.imagePaths});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.05,
      margin: EdgeInsets.only(left: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imagePaths.length < 4 ? imagePaths.length : 4,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Align(
            widthFactor: 0.3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                  width: 35.0,
                  height: 35.0,
                  child: ImageLoaderWidget(imageUrl: imagePaths[index].profileImage,)),
            ),
            // child: CircleAvatar(
            //   radius: 40,
            //   backgroundImage: NetworkImage(imagePaths[index].profileImage),
            // ),
          );
        },
      ),
    );
  }
}

