import 'package:cloud_firestore/cloud_firestore.dart';

class SendRequestModel {
  String id;
  String requestID;
  String userUID;
  String customerID;
  String title;
  String price;
  String status;
  DateTime timestamp;
  String currentDate;
  String currentTime;
  String tax;
  String fees;
  String total;
  String details;
  String documentUrl;
  String profileImage;

  SendRequestModel({
    required this.id,
    required this.requestID,
    required this.userUID,
    required this.customerID,
    required this.title,
    required this.price,
    required this.profileImage,
    DateTime? timestamp,
    String? currentDate,
    String? currentTime,
    required this.tax,
    this.status = "new",
    required this.fees,
    required this.total,
    required this.details,
    required this.documentUrl,
  })  : this.timestamp = timestamp ?? DateTime.now(),
        this.currentDate = currentDate ??
            '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
        this.currentTime = currentTime ??
            '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'requestID': requestID,
      'userUID': userUID,
      'customerID': customerID,
      'profileImage': profileImage,
      'status': status,
      'title': title,
      'price': price,
      'timestamp': timestamp.toIso8601String(),
      'currentDate': currentDate,
      'currentTime': currentTime,
      'tax': tax,
      'fees': fees,
      'total': total,
      'details': details,
      'documentUrl': documentUrl,
    };
  }

  factory SendRequestModel.fromMap(Map<String, dynamic> map) {
    return SendRequestModel(
      id: map['id'] ?? '',
      requestID: map['requestID'] ?? '',
      userUID: map['userUID'] ?? '',
      profileImage: map['profileImage'] ?? '',
      customerID: map['customerID'] ?? '',
      title: map['title'] ?? '',
      status: map['status'] ?? 'new',
      price: map['price'] ?? '',
      timestamp: map['timestamp'] != null
          ? DateTime.parse(map['timestamp'])
          : DateTime.now(),
      currentDate: map['currentDate'] ??
          '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
      currentTime: map['currentTime'] ??
          '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
      tax: map['tax'] ?? '',
      fees: map['fees'] ?? '',
      total: map['total'] ?? '',
      details: map['details'] ?? '',
      documentUrl: map['documentUrl'] ?? '',
    );
  }

  factory SendRequestModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return SendRequestModel(
      id: doc.id,
      requestID: data['requestID'] ?? '',
      userUID: data['userUID'] ?? '',
      customerID: data['customerID'] ?? '',
      profileImage: data['profileImage'] ?? '',
      title: data['title'] ?? '',
      status: data['status'] ?? 'new',
      price: data['price'] ?? '',
      timestamp: data['timestamp'] != null
          ? DateTime.parse(data['timestamp'])
          : DateTime.now(),
      currentDate: data['currentDate'] ??
          '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
      currentTime: data['currentTime'] ??
          '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
      tax: data['tax'] ?? '',
      fees: data['fees'] ?? '',
      total: data['total'] ?? '',
      details: data['details'] ?? '',
      documentUrl: data['documentUrl'] ?? '',
    );
  }
}
