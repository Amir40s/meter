import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meter/constant.dart';
import 'package:meter/constant/res/app_color/app_color.dart';
import 'package:provider/provider.dart';

import '../../provider/chat/chat_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../widgets/chat_header.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/text_widget.dart';

class ChatScreen extends StatelessWidget {
  final String userUID, name,image,otherEmail,chatRoomId;
  const ChatScreen({Key? key, required this.userUID, required this.name, required this.image, required this.otherEmail, required this.chatRoomId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatProvider>(context,listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            ChatHeader(imageUrl: image, name: name,),
            Expanded(
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
                              color: isCurrentUser ? AppColor.primaryColor : Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: isCurrentUser
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.end,
                              children: [
                                Text(
                                  messageText,
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 3),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      relativeTime,
                                      style: TextStyle(
                                        color: Colors.white70,
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
            _buildMessageInput(context,provider,otherEmail),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context,ChatProvider provider,String otherEmail) {
    final provider = Provider.of<ChatProvider>(context, listen: false);
    final TextEditingController _controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              controller: _controller,
              hintText: "Send a message", title: '',
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () async{
              final text = _controller.text;
              if (text.isNotEmpty) {


                provider.sendMessage(
                    chatRoomId: chatRoomId, message: text,otherEmail: otherEmail
                );
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}

