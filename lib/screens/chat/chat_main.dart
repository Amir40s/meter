// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:meter/constant.dart';
// import 'package:meter/model/chat/userchat_model.dart';
// import 'package:meter/widgets/image_loader_widget.dart';
// import 'package:provider/provider.dart';
// import '../../constant/res/app_color/app_color.dart';
// import '../../constant/res/app_images/app_images.dart';
// import '../../model/chat/chatroom_model.dart';
// import '../../provider/chat/chat_controller.dart';
// import '../../provider/chat/chat_provider.dart';
// import '../../widgets/custom_textfield.dart';
// import '../../widgets/text_widget.dart';
// import 'chat_detail.dart';
//
// class ChatMain extends StatelessWidget {
//   const ChatMain({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(ChatSearchController());
//     return SafeArea(
//       child: Scaffold(
//           backgroundColor: AppColor.whiteColor,
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(14.0),
//               child: Column(
//                 children: [
//                   SizedBox(height: Get.height * 0.02,),
//
//                   const TextWidget(
//                     title: "Message",
//                     textColor: AppColor.semiDarkGrey,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//
//                   CustomTextField(
//                       controller: controller.searchController,
//                       prefixImagePath: AppImage.search,
//                       hintText: "Search".tr,
//                       onChanged: (value) {
//                         controller.updateSearchQuery(value);
//                       },
//                       title: ""),
//
//                   SizedBox(height: Get.height * 0.02,),
//
//                   Consumer<ChatProvider>(
//                     builder: (context, chatProvider, _) {
//                       return Obx((){
//                         final searchQuery = controller.searchQuery.value.toLowerCase();
//
//                         return StreamBuilder<List<ChatRoomModel>>(
//                           stream: chatProvider.getChatRoomsStream(),
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState == ConnectionState.waiting) {
//                               return const  Center(
//                                 child: CircularProgressIndicator(),
//                               );
//                             }
//                             if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                               return   Center(
//                                 child: Text('No chats available'.tr),
//                               );
//                             }
//                        //     var chatRooms = snapshot.data!;
//
//                             var chatRooms = snapshot.data!
//                                 .where((chatRoom) {
//                               var otherUserEmail = chatRoom.users
//                                   .firstWhere((user) => user != getCurrentUid().toString());
//                               var otherUser = chatProvider.users.firstWhere(
//                                     (user) => user.userId == otherUserEmail,
//                                 orElse: () => UserchatModel(
//                                   id: '',
//                                   ownerName: 'Unknown',
//                                   email: otherUserEmail,
//                                   profilePicture: '',
//                                   userId: '',
//                                 ),
//                               );
//                               return otherUser.ownerName.toLowerCase().contains(searchQuery);
//                             }).toList();
//
//                             // Debug output
//                             log('Search Query: $searchQuery');
//                             log('Filtered Chat Rooms Count: ${chatRooms.length}');
//
//                             if (chatRooms.isEmpty) {
//                               return const Center(
//                                 child: Text('No chats match the search criteria'),
//                               );
//                             }
//
//                             return ListView.separated(
//                               itemCount: chatRooms.length,
//                               shrinkWrap: true,
//                               itemBuilder: (context, index) {
//                                 if (index >= chatRooms.length) {
//                                   // Safe guard
//                                   return const SizedBox.shrink();
//                                 }
//                                 final chatRoom = chatRooms[index];
//                                 final unreadCount =  chatProvider.unreadMessageCounts[chatRoom.id] ?? 0;
//                                 var otherUserEmail = chatRoom.users.firstWhere((user) => user != getCurrentUid().toString());
//                                 var lastMessage = chatRoom.lastMessage;
//                                 var timeStamp = chatRoom.lastTimestamp;
//                                 var userStatus = chatRoom.userStatus;
//
//
//                                 log("message $unreadCount");
//                                 // final relativeTime = timeStamp != null
//                                 //     ? timeago.format(timeStamp.toDate())
//                                 //     : '';
//
//                                 log("Other Email:: $otherUserEmail");
//                                 log("message ${chatProvider.users.firstWhere(
//                                         (user) => user.userId == otherUserEmail,
//                                     orElse: () => UserchatModel(
//                                         id: '',
//                                         ownerName: 'Unknown',
//                                         email: otherUserEmail,
//                                         profilePicture: '',
//                                         userId: ''
//                                     ))}");
//
//                                 // Retrieve user information from ChatProvider
//                                 var otherUser =  chatProvider.users.firstWhere(
//                                       (user) => user.userId == otherUserEmail,
//                                   orElse: () => UserchatModel(
//                                       id: '',
//                                       ownerName: 'Unknown',
//                                       email: otherUserEmail,
//                                       profilePicture: '',
//                                       userId: ''
//                                   ), // Default user
//                                 );
//
//                                 log("Other UserUID:: ${otherUser.userId}");
//                                 return ListTile(
//                                   leading: CircleAvatar(
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(50.0),
//                                       child: ImageLoaderWidget(imageUrl: otherUser.profilePicture,),
//                                     ),// Assuming image is a URL
//                                   ),
//                                   title: TextWidget(
//                                     title: otherUser.ownerName,
//                                     fontSize: 14.0,
//                                     textColor: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                     textAlign: TextAlign.start,
//
//                                   ),
//                                   // title: Text(otherUserEmail),
//                                   subtitle: TextWidget(
//                                     title: lastMessage.toString(),
//                                     fontSize: 12.0,
//                                     textColor: Colors.grey,
//                                     textAlign: TextAlign.start,
//                                   ),
//                                   trailing: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: [
//                                       TextWidget(
//                                         title: convertTimestamp(timeStamp.toString()),
//                                         fontSize: 12.0,
//                                         textColor: Colors.black,
//                                       ),
//                                      const SizedBox(height: 10.0,),
//                                       chatRoom.isMessage == getCurrentUid().toString() && chatRoom.isMessage !="seen"
//                                           ? const CircleAvatar(
//                                         radius: 7,
//                                         backgroundColor: AppColor.primaryColor,
//                                       ) : const SizedBox.shrink()
//                                     ],
//                                   ),
//                                   onTap: () async{
//                                     final chatRoomId = await context.read<ChatProvider>().createOrGetChatRoom(otherUser.userId,"");
//                                     final userBlockStatus = await context.read<ChatProvider>().getUserStatus(chatRoomId);
//                                     Provider.of<ChatProvider>(context,listen: false).updateMessageStatus(chatRoomId);
//                                     log("Id in home Chat Main::${otherUser.id} and ${otherUser.userId}");
//
//                                     Get.to(ChatDetail(
//                                       userUID: otherUser.id,
//                                       name: otherUser.ownerName,
//                                       image: otherUser.profilePicture,
//                                       otherEmail: otherUser.userId,
//                                       chatRoomId: chatRoomId, userStatus: userBlockStatus,
//                                     ));
//                                     await chatProvider.getUnreadMessageCount(chatRoom.id);
//                                     log("message ${ chatProvider.getUnreadMessageCount(chatRoom.id).toString()}");
//
//
//                                   },
//                                 );
//                               },
//                               separatorBuilder: (context, index) {
//                                 return const Divider(
//                                   color: Colors.grey,
//                                 );
//                               },
//                             );
//
//                           },
//                         );
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/constant.dart';
import 'package:meter/model/chat/userchat_model.dart';
import 'package:meter/widgets/image_loader_widget.dart';
import 'package:provider/provider.dart';
import '../../constant/res/app_color/app_color.dart';
import '../../constant/res/app_images/app_images.dart';
import '../../model/chat/chatroom_model.dart';
import '../../provider/chat/chat_controller.dart';
import '../../provider/chat/chat_provider.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/text_widget.dart';
import 'chat_detail.dart';

class ChatMain extends StatefulWidget {
  const ChatMain({super.key});

  @override
  State<ChatMain> createState() => _ChatMainState();
}

class _ChatMainState extends State<ChatMain> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatSearchController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                SizedBox(height: Get.height * 0.02),
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
                  onChanged: (value) {
                    controller.updateSearchQuery(value);
                  },
                  title: "",
                ),
                SizedBox(height: Get.height * 0.02),
                Consumer<ChatProvider>(
                  builder: (context, chatProvider, _) {
                    return Obx(() {
                      final searchQuery = controller.searchQuery.value.toLowerCase();

                      return StreamBuilder<List<ChatRoomModel>>(
                        stream: chatProvider.getChatRoomsStream(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Center(
                              child: Text('No chats available'.tr),
                            );
                          }

                          var chatRooms = snapshot.data!
                              .where((chatRoom) {
                            var otherUserEmail = chatRoom.users
                                .firstWhere((user) => user != getCurrentUid().toString());
                            var otherUser = chatProvider.users.firstWhere(
                                  (user) => user.userId == otherUserEmail,
                              orElse: () => UserchatModel(
                                id: '',
                                ownerName: 'Unknown',
                                email: otherUserEmail,
                                profilePicture: '',
                                userId: '',
                              ),
                            );
                            return otherUser.ownerName.toLowerCase().contains(searchQuery);
                          }).toList();

                          if (chatRooms.isEmpty) {
                            return const Center(
                              child: Text('No chats match the search criteria'),
                            );
                          }

                          return ListView.separated(
                            itemCount: chatRooms.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (index >= chatRooms.length) {
                                return const SizedBox.shrink();
                              }
                              final chatRoom = chatRooms[index];
                              final unreadCount = chatProvider.unreadMessageCounts[chatRoom.id] ?? 0;
                              var otherUserEmail = chatRoom.users
                                  .firstWhere((user) => user != getCurrentUid().toString());
                              var lastMessage = chatRoom.lastMessage;
                              var timeStamp = chatRoom.lastTimestamp;

                              var otherUser = chatProvider.users.firstWhere(
                                    (user) => user.userId == otherUserEmail,
                                orElse: () => UserchatModel(
                                  id: '',
                                  ownerName: 'Unknown',
                                  email: otherUserEmail,
                                  profilePicture: '',
                                  userId: '',
                                ),
                              );

                              return ListTile(
                                leading: CircleAvatar(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: ImageLoaderWidget(imageUrl: otherUser.profilePicture),
                                  ),
                                ),
                                title: TextWidget(
                                  title: otherUser.ownerName,
                                  fontSize: 14.0,
                                  textColor: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.start,
                                ),
                                subtitle: TextWidget(
                                  title: lastMessage ?? '',
                                  fontSize: 12.0,
                                  textColor: Colors.grey,
                                  textAlign: TextAlign.start,
                                ),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextWidget(
                                      title: timeStamp != null ? convertTimestamp(timeStamp.toString()) : '',
                                      fontSize: 12.0,
                                      textColor: Colors.black,
                                    ),
                                    const SizedBox(height: 10.0),
                                    unreadCount > 0
                                        ? CircleAvatar(
                                      radius: 7,
                                      backgroundColor: AppColor.primaryColor,
                                    )
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                                onTap: () async {
                                  final chatRoomId = await context
                                      .read<ChatProvider>()
                                      .createOrGetChatRoom(otherUser.userId, "");
                                  final userBlockStatus = await context
                                      .read<ChatProvider>()
                                      .getUserStatus(chatRoomId);
                                  context.read<ChatProvider>().updateMessageStatus(chatRoomId);

                                  Get.to(() => ChatDetail(
                                    userUID: otherUser.id,
                                    name: otherUser.ownerName,
                                    image: otherUser.profilePicture,
                                    otherEmail: otherUser.userId,
                                    chatRoomId: chatRoomId,
                                    userStatus: userBlockStatus,
                                  ));
                                  await chatProvider.getUnreadMessageCount(chatRoom.id);
                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                color: Colors.grey,
                              );
                            },
                          );
                        },
                      );
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
