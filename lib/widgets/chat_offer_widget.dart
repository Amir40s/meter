import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:meter/constant.dart';
import 'package:meter/constant/routes/routes_name.dart';
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
    final currentUser = getCurrentUid().toString();
    return Container(
      width: Get.width * 0.54,
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           TextWidget(title: "Project Offer",textColor: currentUser == otherEmail ? Colors.white : Colors.black,),
          const SizedBox(height: 20.0,),
          Row(
            children: [
               Icon(Icons.paid,color: currentUser == otherEmail ? Colors.white : Colors.black,),
              const SizedBox(width: 5.0,),
              TextWidget(title: "Price:\$$price",textColor: currentUser == otherEmail ? Colors.white : Colors.black,)
            ],
          ),
          const SizedBox(height: 10.0,),
          Row(
            children: [
               Icon(Icons.paid,color: currentUser == otherEmail ? Colors.white : Colors.black,),
              const SizedBox(width: 5.0,),
              TextWidget(title: "Tax:\$$tax",textColor: currentUser == otherEmail ? Colors.white : Colors.black)
            ],
          ),
          const SizedBox(height: 10.0,),
          Row(
            children: [
               Icon(Icons.featured_play_list,color: currentUser == otherEmail ? Colors.white : Colors.black,),
              const SizedBox(width: 5.0,),
              TextWidget(title: "Fees: $fees",textColor: currentUser == otherEmail ? Colors.white : Colors.black,)
            ],
          ),
          const SizedBox(height: 10.0,),
          Row(
            children: [
               Icon(Icons.paid,color: currentUser == otherEmail ? Colors.white : Colors.black,),
              const SizedBox(width: 5.0,),
              TextWidget(title: "Total:\$$total",textColor: currentUser == otherEmail ? Colors.white : Colors.black,)
            ],
          ),
          const SizedBox(height: 10.0,),
          TextWidget(title: "Description: $description",
            textColor: currentUser == otherEmail ? Colors.white : Colors.black,
            fontWeight: FontWeight.normal,),


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
                    Get.toNamed(RoutesName.paymentScreen,arguments: {
                      'price' : price.toString()
                    });
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


