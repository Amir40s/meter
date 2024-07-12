import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/widgets/border_painter_widget.dart';
import 'package:meter/widgets/text_widget.dart';

import '../constant/res/app_color/app_color.dart';
import '../constant/res/app_images/app_images.dart';

class ImagePickWidget extends StatelessWidget {
  final String title;
  final String? imagePath;
  final VoidCallback? onTap;
  final bool isFile;
  final String fileName;
  final String? imageUrl;
  const ImagePickWidget(
      {super.key,
        required this.title,
        this.imagePath,
        this.onTap,
        this.imageUrl,
        this.isFile = false,
        this.fileName = ""});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: BorderPainterWidget(
          color: AppColor.semiTransparentDarkGrey,
          strokeWidth: 1.0,
          dashLength: 8.0,
          dashSpacing: 7.0,
        ),
        child: Container(
          width: Get.width * 1,
          padding: EdgeInsets.all(Get.width * 0.10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            // border: Border.all(color: AppColor.semiTransparentDarkGrey)
          ),
          child: imagePath != null && imagePath != ""
              ? Image.file(
            File(imagePath!),
            height: Get.height * 0.20,
            width: Get.width,
          )
              : imageUrl != null && imageUrl != ""
              ? Image.network(
            imageUrl!,
            height: Get.height * 0.20,
            width: Get.width,
          )
              : isFile
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppImage.pdf,
                width: 24,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              TextWidget(
                  title: fileName,
                  textColor: AppColor.primaryColor,
                  fontSize: 16),
            ],
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppImage.upload,
                width: 24,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              TextWidget(
                  title: title,
                  textColor: AppColor.primaryColor,
                  fontSize: 16),
              SizedBox(
                height: Get.height * 0.01,
              ),
              const TextWidget(
                  title: "(Maximum file size: 25MB)",
                  textColor: AppColor.semiTransparentDarkGrey,
                  fontSize: 14)
            ],
          ),
        ),
      ),
    );
  }
}
