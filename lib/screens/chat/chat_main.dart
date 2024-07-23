import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant.dart';
import 'package:meter/model/chat/userchat_model.dart';
import 'package:provider/provider.dart';

import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../controller/chat/chat_controller_main.dart';
import '../../model/chat/chatroom_model.dart';
import '../../provider/chat/chat_provider.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/text_widget.dart';
import 'chat_detail.dart';
import 'chat_screen.dart';

class ChatMain extends StatelessWidget {
  const ChatMain({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatControllerMain());
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.whiteColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  const TextWidget(
                    title: "Message",
                    textColor: AppColor.semiDarkGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomTextField(
                      controller: controller.searchController,
                      prefixImagePath: AppImage.search,
                      hintText: "Search".tr,
                      title: ""),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  // ListView.builder(
                  //     itemCount: 12,
                  //     shrinkWrap: true,
                  //     physics: const ScrollPhysics(),
                  //     itemBuilder: (itemBuilder, index) {
                  //       return Transform.translate(
                  //         offset: const Offset(-18, 0),
                  //         child: ListTile(
                  //           onTap: () {
                  //             Get.to(const ChatDetail());
                  //           },
                  //           leading: const CircleAvatar(
                  //             radius: 30,
                  //             backgroundImage: AssetImage(AppImage.profile),
                  //           ),
                  //           trailing: const TextWidget(
                  //               title: "10:25",
                  //               textColor: AppColor.semiTransparentDarkGrey,
                  //               fontSize: 11),
                  //           title: const TextWidget(
                  //               textAlign: TextAlign.left,
                  //               title: "Name",
                  //               textColor: AppColor.semiDarkGrey,
                  //               fontSize: 14),
                  //           subtitle: const TextWidget(
                  //             textAlign: TextAlign.left,
                  //             title: "Message would be here okk",
                  //             textColor: AppColor.semiTransparentDarkGrey,
                  //             fontSize: 12,
                  //             textOverflow: TextOverflow.ellipsis,
                  //           ),
                  //         ),
                  //       );
                  //     })
                  Consumer<ChatProvider>(
                    builder: (context, chatProvider, _) {
                      return StreamBuilder<List<ChatRoomModel>>(
                        stream: chatProvider.getChatRoomsStream(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const  Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const  Center(
                              child: Text('No chats available'),
                            );
                          }
                          var chatRooms = snapshot.data!;
                          return ListView.separated(
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final chatRoom = chatRooms[index];
                              final unreadCount =  chatProvider.unreadMessageCounts[chatRoom.id] ?? 0;
                              var otherUserEmail = chatRoom.users.firstWhere((user) => user != getCurrentUid().toString());
                              var lastMessage = chatRoom.lastMessage;
                              // var timeStamp = chatRoom[index].lastTimestamp;


                              log("message $unreadCount");
                              // final relativeTime = timeStamp != null
                              //     ? timeago.format(timeStamp.toDate())
                              //     : '';

                              log("message ${chatProvider.users.firstWhere(
                                      (user) => user.id == otherUserEmail,
                                  orElse: () => UserchatModel(
                                      id: '',
                                      ownerName: 'Unknown',
                                      email: otherUserEmail,
                                      profilePicture: '',
                                      userUID: ''
                                  ))}");

                              // Retrieve user information from ChatProvider
                              var otherUser =  chatProvider.users.firstWhere(
                                    (user) => user.id == otherUserEmail,
                                orElse: () => UserchatModel(
                                    id: '',
                                    ownerName: 'Unknown',
                                    email: otherUserEmail,
                                    profilePicture: '',
                                    userUID: ''
                                ), // Default user
                              );

                              log("message ${otherUser.profilePicture}");
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(otherUser.profilePicture), // Assuming image is a URL
                                ),
                                title: TextWidget(title: otherUser.ownerName,fontSize: 14.0,textColor: Colors.black,fontWeight: FontWeight.bold),
                                // title: Text(otherUserEmail),
                                subtitle: TextWidget(title: lastMessage.toString(),fontSize: 12.0,textColor: Colors.black,),
                                trailing: chatRoom.isMessage == getCurrentUid().toString() && chatRoom.isMessage !="seen"
                                    ? const CircleAvatar(
                                  radius: 7,
                                  backgroundColor: AppColor.primaryColor,
                                )
                                    : null,
                                onTap: () async{
                                  final chatRoomId = await context.read<ChatProvider>().createOrGetChatRoom(otherUser.email,"");
                                  Provider.of<ChatProvider>(context,listen: false).updateMessageStatus(chatRoomId);
                                  log("Id in home Chat Main::${otherUser.id} and ${otherUser.email}");
                                  Get.to(ChatScreen(
                                    userUID: otherUser.id,
                                    name: otherUser.ownerName,
                                    image: otherUser.profilePicture,
                                    otherEmail: otherUser.email,
                                    chatRoomId: chatRoomId,
                                  ));
                                  await chatProvider.getUnreadMessageCount(chatRoom.id);
                                  log("message ${ chatProvider.getUnreadMessageCount(chatRoom.id).toString()}");

                                  // await chatProvider.getCollectionLength(chatRoom.id);
                                  // log('get Messages ${chatProvider.collectionLength}');

                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                color: Colors.black,
                              );
                            },
                          );

                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
