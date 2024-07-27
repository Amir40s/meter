import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:meter/constant.dart';
import 'package:meter/provider/chat/chat_provider.dart';
import 'package:meter/widgets/custom_button.dart';
import 'package:meter/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class ChatOfferWidget extends StatelessWidget {
  final String price,tax,fees,total,description,offerStatus,messageID,chatRoomId,otherEmail;
  const ChatOfferWidget({
    super.key,
    required this.price,
    required this.tax,
    required this.fees,
    required this.total,
    required this.description,
    required this.offerStatus,
    required this.chatRoomId,
    required this.otherEmail,
    required this.messageID,

  });

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context,listen: false);
    return Container(
      width: Get.width * 0.54,
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TextWidget(title: "Project Offer",textColor: Colors.white,),
          const SizedBox(height: 20.0,),
          Row(
            children: [
              const Icon(Icons.paid,color: Colors.white,),
              const SizedBox(width: 5.0,),
              TextWidget(title: "Price:\$$price",textColor: Colors.white,)
            ],
          ),
          const SizedBox(height: 10.0,),
          Row(
            children: [
              const Icon(Icons.paid,color: Colors.white,),
              const SizedBox(width: 5.0,),
              TextWidget(title: "Tax:\$$tax",textColor: Colors.white,)
            ],
          ),
          const SizedBox(height: 10.0,),
          Row(
            children: [
              const Icon(Icons.featured_play_list,color: Colors.white,),
              const SizedBox(width: 5.0,),
              TextWidget(title: "Fees: $fees",textColor: Colors.white,)
            ],
          ),
          const SizedBox(height: 10.0,),
          Row(
            children: [
              const Icon(Icons.paid,color: Colors.white,),
              const SizedBox(width: 5.0,),
              TextWidget(title: "Total:\$$total",textColor: Colors.white,)
            ],
          ),
          const SizedBox(height: 10.0,),
          TextWidget(title: "Description: $description",textColor: Colors.white,fontWeight: FontWeight.normal,),


          const SizedBox(height: 25.0,),
          if(offerStatus == "pending")...[
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                      title: "Cancel",
                      backgroundColor: Colors.grey,

                      onTap: () async{
                       await chatProvider.updateOfferMessage(
                            status: "cancel",
                            messageID: messageID,
                            chatRoomId: chatRoomId,
                            otherEmail: otherEmail
                        );
                       Fluttertoast.showToast(msg: "Offer Cancelled");

                      }),
                ),
                const SizedBox(width: 5.0,),
                Expanded(
                  child: CustomButton(title: "Accept",backgroundColor: Colors.green, onTap: ()async{
                    await chatProvider.updateOfferMessage(
                        status: "accept",
                        messageID: messageID,
                        chatRoomId: chatRoomId,
                        otherEmail: otherEmail
                    );
                    Fluttertoast.showToast(msg: "Offer accepted");
                  }),
                ),
              ],
            )
          ]else if(offerStatus == "cancel")...[
            const TextWidget(title: "Offer Canceled",textColor: Colors.white,)
          ]else...[
            const TextWidget(title: "Offer accepted",textColor: Colors.white,)
          ]

        ],
      ),
    );
  }
}


