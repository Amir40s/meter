import 'package:flutter/material.dart';

import '../constant/res/app_color/app_color.dart';

class CustomLoading extends StatelessWidget {
  final Color color;
  const CustomLoading({super.key, this.color = AppColor.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
