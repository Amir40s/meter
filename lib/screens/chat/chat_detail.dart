import 'dart:developer';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../chat/audio_controller.dart';
import '../../constant.dart';
import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../provider/chat/chat_provider.dart';
import '../../widgets/chat_popup.dart';
import '../../widgets/chat_text_field.dart';
import '../../widgets/circular_container.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/pop_up_manu_widget.dart';
import '../../widgets/text_widget.dart';

class ChatDetail extends StatefulWidget {
  final String userUID, name,image,otherEmail,chatRoomId;
   ChatDetail({super.key, required this.userUID, required this.name, required this.image, required this.otherEmail, required this.chatRoomId});

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  final TextEditingController _controller = TextEditingController();

  late String recordFilePath;

  AudioController audioController = Get.put(AudioController());

  AudioPlayer audioPlayer = AudioPlayer();

  String audioURL = "";

  int i=0;



  // uploadAudio() async {
  //   UploadTask uploadTask = Provider.of<ChatProvider>(context,listen: false).uploadAudio(File(recordFilePath),
  //       "audio/${DateTime.now().millisecondsSinceEpoch.toString()}");
  //   try {
  //     TaskSnapshot snapshot = await uploadTask;
  //     audioURL = await snapshot.ref.getDownloadURL();
  //     String strVal = audioURL.toString();
  //
  //     log("Audio Message Url: $strVal");
  //   } on FirebaseException catch (e) {
  //     setState(() {
  //       audioController.isSending.value = false;
  //     });
  //     Fluttertoast.showToast(msg: e.message ?? e.toString());
  //   }
  // }

  // @override
  @override
  Widget build(BuildContext context) {
    requestMicrophonePermission();
    final provider = Provider.of<ChatProvider>(context,listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.04,
              ),
             const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomBackButton(),
                  TextWidget(
                      title: "Message",
                      textColor: AppColor.semiDarkGrey,
                      fontSize: 16),
                  const ChatPopupMenu()
                ],
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Row(
                children: [
                   CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(widget.image),
                  ),
                  SizedBox(
                    width: Get.width * 0.05,
                  ),
                  TextWidget(
                      title: widget.name,
                      textColor: AppColor.semiDarkGrey,
                      fontSize: 16)
                ],
              ),
              Expanded(
                flex: 8,
                child: StreamBuilder(
                  stream: context.read<ChatProvider>().getMessages(widget.chatRoomId),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    provider.markMessageAsRead(widget.chatRoomId);
                    provider.updateDeliveryStatus(widget.chatRoomId);
                    final messages = snapshot.data!.docs;
                    List<Widget> messageWidgets = [];
                    for (var message in messages) {
                      final messageText = message["text"];
                      final messageSender = message["sender"];
                      final messageTimestamp = message["timestamp"];
                      final isDelivered = message["delivered"];
                      final type = message["type"];

                      final relativeTime = messageTimestamp != null
                          ? timeago.format(messageTimestamp.toDate())
                          : '';

                      // return ListView
                      final isCurrentUser = messageSender == getCurrentUid().toString();

                      final messageWidget = Align(
                        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                          crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: isCurrentUser ? AppColor.primaryColor : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              child: Column(
                                crossAxisAlignment: isCurrentUser
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                 type == "text" ?
                                 Text(
                                   messageText,
                                    style: TextStyle(color:  isCurrentUser ? Colors.white : Colors.black),
                                  ) :
                                 type == "image"  ?
                                 Image.network(message['url']!.toString(),width: 200.0,height: 200.0,)
                                  :
                                  type == "document" ?
                                  Container(
                                    width: 180.0,
                                    height: 180.0,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Stack(children: [
                                          Image.asset(AppImage.docImage),
                                          Positioned(
                                              top: 0,
                                              right: 0,
                                              child: IconButton(
                                                icon: Icon(Icons.save_alt_outlined,color: Colors.white,),
                                                onPressed: () async{
                                                  log("message");
                                                 await provider.downloadFile(message['url'], message['text'],fallbackUrl: message['url']);
                                                },
                                              )
                                          ),
                                        ]),
                                        TextWidget(
                                            title: "Document: ${message['text']}",
                                          textColor: isCurrentUser ? Colors.white : Colors.black,
                                          fontSize: 12.0,
                                        )
                                      ],
                                    ),
                                  ) : type == "voice" ? Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.play_arrow),
                                        onPressed: () async {
                                          // final audioPlayer = FlutterSoundPlayer();
                                          // await audioPlayer.startPlayer(fromURI: message['url']);
                                        },
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Voice Message',
                                        style: TextStyle(color: isCurrentUser ? Colors.white : Colors.black),
                                      )
                                    ],
                                  )
                                        : SizedBox.shrink(),
                                 //  message['type'] == 'text'
                                 //      ? Text(message['text'])
                                 //      : message['type'] == 'image'
                                 //      ? Image.network(message['url']!)
                                 //      : message['type'] == 'document'
                                 //      ? Text('Document: ${message['text']}')
                                 //      : message['type'] == 'voice'
                                 //      ? Icon(Icons.play_arrow)
                                 //      : SizedBox.shrink(),
                                  SizedBox(height: 3),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        relativeTime,
                                        style: TextStyle(
                                          color: isCurrentUser ?  Colors.white70 : Colors.grey,
                                          fontSize: 10,
                                        ),
                                      ),
                                      if (isCurrentUser) ...[
                                        SizedBox(width: 5),
                                        Icon(
                                          message["read"] ? Icons.done_all : Icons.done,
                                          color: message["read"] ? Colors.white :  Colors.white70,
                                          size: 12,
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if(isCurrentUser)
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: TextWidget(title: isDelivered ? "seen" : "deliver", fontSize:  12.0))
                          ],
                        ),
                      );

                      messageWidgets.add(messageWidget);
                    }
                    return ListView(
                      reverse: true,
                      children: messageWidgets,
                    );
                  },
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    PopupMenuButton<String>(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        offset: Offset(0, -Get.height * 0.32),
                        // position: PopU,
                        icon: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.success10,
                          ),
                          child: Image.asset(
                            AppImage.add,
                          ),
                        ),
                        iconSize: 40,
                        onSelected: (String value) {
                          print("You selected $value");
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuWidget(
                              height: Get.height * 0.4,
                              child: ChatAddBottomSheet(
                                chatRoomId: widget.chatRoomId,
                                otherEmail: widget.otherEmail,
                              ),
                            ),
                          ];
                        }),
                    // CircularContainer(
                    //     imagePath: AppImage.add,
                    //     backgroundColor: AppColor.success10,
                    //     onTap: () {
                    //       Get.bottomSheet(
                    //           shape: const RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.only(
                    //               topLeft: Radius.circular(20),
                    //               topRight: Radius.circular(20),
                    //             ),
                    //           ),
                    //           const ChatAddBottomSheet(),
                    //           backgroundColor: AppColor.whiteColor);
                    //     }),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    Expanded(
                        child: ChatTextField(
                          hintText: "Type a message...".tr,controller: _controller,)),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    Row(
                      children: [
                        CircularContainer(imagePath: AppImage.send, onTap: () {
                          final text = _controller.text;
                          if (text.isNotEmpty) {
                            provider.sendMessage(
                                chatRoomId: widget.chatRoomId, message: text,otherEmail: widget.otherEmail, type: 'text'
                            );
                            _controller.clear();
                          }
                        }),

                        GestureDetector(
                          child: Icon(Icons.mic, color: AppColor.primaryColor),
                          onLongPress: () async {
                            var audioPlayer = AudioPlayer();
                            await audioPlayer.play(AssetSource("Notification.mp3"));
                            audioPlayer.onPlayerComplete.listen((a) {
                              audioController.start.value = DateTime.now();
                              startRecord();
                              audioController.isRecording.value = true;
                            });
                          },
                          onLongPressEnd: (details) {
                            stopRecord();
                          },
                        ),

                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
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

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
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
}
