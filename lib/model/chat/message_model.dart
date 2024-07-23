import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id;
  final String text;
  final String sender;
  final DateTime timestamp;
  final bool read;
  final bool delivered;

  MessageModel({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
    required this.read,
    required this.delivered,
  });

  factory MessageModel.fromMap(Map<String, dynamic> data, String id) {
    return MessageModel(
      id: id,
      text: data['text'] ?? '',
      sender: data['sender'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      read: data['read'] ?? false,
      delivered: data['delivered'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'sender': sender,
      'timestamp': timestamp,
      'read': read,
      'delivered': delivered,
    };
  }
}
