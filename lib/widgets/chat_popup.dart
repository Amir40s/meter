import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:meter/bottomSheet/requestForm/request_form_bottom_sheet.dart';
import 'package:meter/widgets/request_widget.dart';
import 'package:meter/widgets/text_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record_mp3/record_mp3.dart';

import '../chat/audio_controller.dart';
import '../constant/res/app_color/app_color.dart';
import '../constant/res/app_images/app_images.dart';
import '../provider/chat/chat_provider.dart';
import 'circular_container.dart';

class ChatAddBottomSheet extends StatefulWidget {
  String chatRoomId,otherEmail;
   ChatAddBottomSheet({super.key,
   this.chatRoomId = '',
   this.otherEmail = '',
   });

  @override
  State<ChatAddBottomSheet> createState() => _ChatAddBottomSheetState();
}

class _ChatAddBottomSheetState extends State<ChatAddBottomSheet> {


  AudioController audioController = Get.put(AudioController());
  late String recordFilePath;

  AudioPlayer audioPlayer = AudioPlayer();

  String audioURL = "";

  double boxWidth = 120.0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatProvider>(context,listen: false);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: Get.height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: twoWidgets(
                    imagePath: AppImage.gallery,
                    onTap: () async {
                      final result = await FilePicker.platform.pickFiles();
                      if (result != null) {
                        final file = result.files.single;
                        final filePath = file.path!;
                        final fileType = file.extension;
                        String messageType;
                        if (fileType == 'mp3' || fileType == 'wav') {
                          messageType = 'voice';
                        } else if (fileType == 'jpg' || fileType == 'png') {
                          messageType = 'image';
                        } else {
                          messageType = 'document';
                        }
                        await provider.sendFileMessage(
                          chatRoomId: widget.chatRoomId,
                          filePath: filePath,
                          type: messageType,
                          otherEmail: widget.otherEmail,
                        );
                      }
                    },
                    iconSize: 25.0,
                    title: "Gallery".tr,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: twoWidgets(
                      imagePath: AppImage.offer,
                      onTap: () {
                        Get.bottomSheet(
                           RequestFormBottomSheet(
                            showPicture: false,
                             chatRoomID: widget.chatRoomId,
                             otherEmail: widget.otherEmail,
                          ),
                          isScrollControlled: false,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                        );
                      },
                      title: "Create an offer".tr),
                ),
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: GestureDetector(
                    onLongPress: () async {
                      var audioPlayer = AudioPlayer();
                      await audioPlayer.play(AssetSource("Notification.mp3"));
                      audioPlayer.onPlayerComplete.listen((a) {
                        audioController.start.value = DateTime.now();
                        startRecord();
                        audioController.isRecording.value = true;
                      });
                    },
                    onLongPressEnd: (details) async {
                      stopRecord();
                      String? url =  await uploadAudio();
                      if(url!=null){
                        provider.sendVoiceMessage(
                            chatRoomId: widget.chatRoomId, text: url,otherEmail: widget.otherEmail
                        );
                      }
                    },
                    child: twoWidgets(
                        imagePath: AppImage.record, onTap: () async{
                    },
                        onSecondTap: (){
                
                        }
                        ,title: "Record".tr),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: twoWidgets(
                      imagePath: AppImage.pickLocation,
                      onTap: () {
                        log("Location tap");
                        provider.sendLocationMessage(
                          chatRoomId: widget.chatRoomId,
                          otherEmail: widget.otherEmail,
                        );
                        // Get.back();
                      },
                      iconSize: 25.0,
                      title: "My Location".tr),
                ),
              )
            ],
          ),
          SizedBox(
            height: Get.height * 0.03,
          ),
        ],
      ),
    );
  }

  Widget twoWidgets(
      {required imagePath, required onTap, required title, iconSize = 30.0,var onSecondTap}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularContainer(
          imagePath: imagePath,
          onTap: onTap,
          onSecondTap: onSecondTap,
          imageSize: iconSize,
        ),
        const SizedBox(
          height: 9,
        ),
        TextWidget(
            title: title, textColor: AppColor.semiDarkGrey, fontSize: 16),
      ],
    );
  }
  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      recordFilePath = await getFilePath();
      RecordMp3.instance.start(recordFilePath, (type) {
        setState(() {});
      });
    } else {}
    setState(() {});
  }

  void stopRecord() async {
    bool stop = RecordMp3.instance.stop();
    audioController.end.value = DateTime.now();
    audioController.calcDuration();
    var ap = AudioPlayer();
    await ap.play(AssetSource("Notification.mp3"));
    ap.onPlayerComplete.listen((a) {});
    if (stop) {
      audioController.isRecording.value = false;
      audioController.isSending.value = true;
    }
  }

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  int i=0;

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath =
        "${storageDirectory.path}/record${DateTime.now().microsecondsSinceEpoch}.acc";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return "$sdPath/test_${i++}.mp3";
  }

  Future<void> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    if (status.isGranted) {
      // Permission granted
    } else if (status.isDenied) {
      // Permission denied
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, open settings
      openAppSettings();
    }
  }
  Future<String?> uploadAudio() async {
    try {
      final chatProvider = Provider.of<ChatProvider>(context, listen: false);
      final uploadTask = chatProvider.uploadAudio(
        File(recordFilePath),
        "audio/${DateTime.now().millisecondsSinceEpoch.toString()}",
      );

      final snapshot = await uploadTask;
      final audioURL = await snapshot.ref.getDownloadURL();
      final strVal = audioURL.toString();

      log("Audio Message Url: $strVal");
      return strVal;
    } on FirebaseException catch (e) {
      setState(() {
        audioController.isSending.value = false;
      });
      Fluttertoast.showToast(msg: e.message ?? e.toString());
      return null;
    }
  }
}

class ChatPopupMenu extends StatelessWidget {
  final String otherUserUid,chatRoomID;
   const ChatPopupMenu({super.key, required this.otherUserUid, required this.chatRoomID});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatProvider>(context,listen: false);
    return PopupMenuButton<String>(
      offset: Offset(0, Get.height * 0.06),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      icon: Image.asset(AppImage.menu),
      onSelected: (String result) {
        switch (result) {
          case 'Report':
            print('Report selected');
            break;
          case 'Block':
            log('Block selected');
            provider.blockUser(chatRoomId: chatRoomID, otherEmail: otherUserUid);
            break;
          case 'Delete Chat':
            print('Delete Chat selected');
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Report',
          child: TextWidget(
              title: "Report".tr,
              textColor: AppColor.semiDarkGrey,
              fontSize: 16),
        ),
        PopupMenuItem<String>(
          value: 'Block'.tr,
          child: TextWidget(
              title: "Block".tr,
              textColor: AppColor.semiDarkGrey,
              fontSize: 16),
        ),
        PopupMenuItem<String>(
          value: 'Delete Chat',
          child: TextWidget(
              title: "Delete Chat".tr,
              textColor: AppColor.semiDarkGrey,
              fontSize: 16),
        ),
      ],
      color: Colors.white, // Set the background color of the popup menu
    );
  }
}
