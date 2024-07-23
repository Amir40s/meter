import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meter/model/requestServices/send_request_model.dart';

class DbProvider extends ChangeNotifier{

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> sendRequestDB(SendRequestModel item) async {
    await _db.collection("requestService").doc(item.requestID).update({
      "status" : item.status
    });
    await _db
        .collection("requestService")
        .doc(item.requestID)
        .collection('proposals')
        .doc(item.id)
        .set(item.toMap());
    notifyListeners();
  }
}