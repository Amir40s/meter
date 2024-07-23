
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meter/constant/res/app_color/app_color.dart';
import 'package:meter/widgets/text_widget.dart';
class ChatHeader extends StatelessWidget {
  final String imageUrl,name;
  const ChatHeader({super.key, required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          )
      ),
      child: Row(
        children: [
          GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Icon(Icons.arrow_back,color: Colors.white,)),
          SizedBox(width: 10.0,),
          Container(
            width: 50.0,
            height: 50.0,
            child: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
          SizedBox(width: 10.0,),
          TextWidget(title: name, fontSize: 14.0,textColor: Colors.white,fontWeight: FontWeight.bold,)
        ],
      ),
    );
  }
}
