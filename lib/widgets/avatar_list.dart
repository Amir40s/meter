import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
