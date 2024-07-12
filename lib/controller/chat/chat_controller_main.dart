import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatControllerMain extends GetxController {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> messages = [
    {
      "isMe": false,
      "content": "Hey There",
      "dateTime": DateTime.now().subtract(Duration(hours: 20)),
    },
    {
      "isMe": true,
      "content": "Hello!",
      "dateTime": DateTime.now().subtract(Duration(hours: 18)),
    },
    {
      "isMe": false,
      "content": "How are you?",
      "dateTime": DateTime.now().subtract(Duration(hours: 16)),
    },
    {
      "isMe": true,
      "content": "I'm good, thanks!",
      "dateTime": DateTime.now().subtract(Duration(hours: 14)),
    },
    {
      "isMe": false,
      "content": "What about you?",
      "dateTime": DateTime.now().subtract(Duration(hours: 12)),
    },
    {
      "isMe": true,
      "content": "Doing well, working on some projects.",
      "dateTime": DateTime.now().subtract(Duration(hours: 10)),
    },
  ];
}
