import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meter/constant/res/app_color/app_color.dart';
import 'package:meter/constant/res/app_images/app_images.dart';



class ImageLoaderWidget extends StatelessWidget {
  final String imageUrl;
  const ImageLoaderWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => const CircularProgressIndicator(color: AppColor.primaryColor,), // Path to your placeholder image
      errorWidget: (context, url, error) => Image.asset(AppImage.person), // Display an error icon if the image fails to load
      fit: BoxFit.cover,
    );
  }
}
