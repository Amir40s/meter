import 'dart:developer';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meter/widgets/chat_offer_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import '../../chat/audio_controller.dart';
import '../../constant.dart';
import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../provider/chat/chat_provider.dart';
import '../../provider/player/audio_player_provider.dart';
import '../../widgets/chat_popup.dart';
import '../../widgets/chat_text_field.dart';
import '../../widgets/circular_container.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/pop_up_manu_widget.dart';
import '../../widgets/text_widget.dart';

class ChatDetail extends StatelessWidget {
  final String userUID, name,image,otherEmail,chatRoomId;
  ChatDetail({super.key, required this.userUID, required this.name, required this.image, required this.otherEmail, required this.chatRoomId});

  final TextEditingController _controller = TextEditingController();

  late String recordFilePath;

  AudioController audioController = Get.put(AudioController());

  AudioPlayer audioPlayer = AudioPlayer();


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
                    backgroundImage: NetworkImage(image),
                  ),
                  SizedBox(
                    width: Get.width * 0.05,
                  ),
                  TextWidget(
                      title: name,
                      textColor: AppColor.semiDarkGrey,
                      fontSize: 16)
                ],
              ),
              Expanded(
                flex: 8,
                child: StreamBuilder(
                  stream: context.read<ChatProvider>().getMessages(chatRoomId),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    provider.markMessageAsRead(chatRoomId);
                    provider.updateDeliveryStatus(chatRoomId);
                    final messages = snapshot.data!.docs;
                    List<Widget> messageWidgets = [];
                    for (var message in messages) {
                      final messageText = message["text"];
                      final messageSender = message["sender"];
                      final messageTimestamp = message["timestamp"];
                      final isDelivered = message["delivered"];
                      final type = message["type"];
                      final documentId = message.id.toString();

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
                                color: isCurrentUser  ? AppColor.primaryColor : Colors.white,
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
                                        Stack(
                                            children: [
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
                                  ) : type == "voice" ?
                                  Container(
                                    width: Get.width * 0.54,
                                    child: ListTile(
                                      title: Text("Voice Message"),
                                      trailing: PlayButton(audioUrl: message['text']),
                                    ),
                                  ) : type == "location"
                                      ?

                                  Container(
                                    width: Get.width * 0.54,
                                    height: 150,
                                    child: Stack(
                                      children: [
                                        GoogleMap(
                                          initialCameraPosition: CameraPosition(
                                            target: LatLng(
                                              double.parse(message['latitude'].toString()),
                                              double.parse(message['longitude'].toString()),
                                            ),
                                            zoom: 15,
                                          ),
                                          markers: {
                                            Marker(
                                              markerId: MarkerId('location'),
                                              position: LatLng(
                                                double.parse(message['latitude'].toString()),
                                                double.parse(message['longitude'].toString()),
                                              ),
                                            ),
                                          },
                                          // Optional: Set map type or other properties
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: IconButton(
                                            icon: Icon(Icons.location_on_sharp, color: Colors.blue),
                                            onPressed: () {
                                             // log("Current Message ID ${message.id}");
                                              _openMap(message['latitude'].toString(), message['longitude'].toString());
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                      : type == "offer" ?
                                      ChatOfferWidget(
                                        price: message['text'],
                                        tax: message['tax'],
                                        fees: message['fees'],
                                        total: message['total'],
                                        description: message['details'],
                                        offerStatus: message['offerStatus'],
                                        messageID: documentId,
                                        chatRoomId: chatRoomId,
                                        otherEmail: otherEmail,
                                      )
                                      : SizedBox.shrink(),
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
                                chatRoomId: chatRoomId,
                                otherEmail: otherEmail,
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
                                chatRoomId: chatRoomId, message: text,otherEmail: otherEmail, type: 'text'
                            );
                            _controller.clear();
                          }
                        }),

                        // location button
                        // IconButton(
                        //   icon: Icon(Icons.location_on),
                        //   onPressed: () {
                        //     provider.sendLocationMessage(
                        //       chatRoomId: chatRoomId,
                        //       otherEmail: otherEmail,
                        //     );
                        //   },
                        // ),
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

  Future<void> _openMap(String latitude, String longitude) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
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
}

class PlayButton extends StatelessWidget {
  final String audioUrl;

  PlayButton({required this.audioUrl});

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayerProvider>(
      builder: (context, audioPlayerProvider, child) {
        bool isPlaying = audioPlayerProvider.currentPlayingUrl == audioUrl &&
            audioPlayerProvider.audioPlayerState == PlayerState.playing;

        return IconButton(
          icon: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
          ),
          onPressed: () {
            if (isPlaying) {
              audioPlayerProvider.pause();
            } else {
              audioPlayerProvider.play(audioUrl);
            }
          },
        );
      },
    );
  }

  // Future<void> _deleteSelectedMessages() async {
  //   final provider = Provider.of<ChatProvider>(context, listen: false);
  //   for (String messageId in selectedMessages) {
  //     await provider.deleteMessage(widget.chatRoomId, messageId);
  //   }
  //   Fluttertoast.showToast(msg: "Selected messages deleted");
  // }
}

