import 'package:flutter/material.dart';
import 'package:meter/widgets/text_widget.dart';
import '../constant/res/app_color/app_color.dart';
import '../constant/res/app_images/app_images.dart';

class EditPopUpWidget extends StatelessWidget {
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;
  const EditPopUpWidget(
      {super.key, required this.onEditTap, required this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Image.asset(AppImage.verticalMenu),
      onSelected: (String result) {
        switch (result) {
          case 'Edit':
            onEditTap();
            break;
          case 'Delete':
            onDeleteTap();
            print('Block selected');
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Edit',
          child: Row(
            children: [
              Image.asset(
                AppImage.edit,
                width: 16,
              ),
              SizedBox(
                width: 10,
              ),
              TextWidget(
                  title: "Edit",
                  textColor: AppColor.semiDarkGrey,
                  fontSize: 16),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'Delete',
          child: GestureDetector(
            onTap: onDeleteTap,
            child: Row(
              children: [
                Image.asset(
                  AppImage.delete,
                  width: 16,
                ),
                SizedBox(
                  width: 10,
                ),
                TextWidget(
                    title: "Delete",
                    textColor: AppColor.semiDarkGrey,
                    fontSize: 16),
              ],
            ),
          ),
        ),
      ],
      color: Colors.white, // Set the background color of the popup menu
    );
  }
}
