import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meter/model/requestServices/request_services_model.dart';

import '../model/requestServices/send_request_model.dart';

class FirebaseServicesProvider extends ChangeNotifier{

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<SendRequestModel> _proposals = [];
  List<RequestServicesModel> _requestServices = [];

  List<RequestServicesModel> get deviceModel => _requestServices;
  List<SendRequestModel> get proposals => _proposals;

  Stream<List<RequestServicesModel>> getRequestServices() {
    log("message get requestServices}");
    return _db.collection("requestService")
        .orderBy("timestamp", descending: true)
        .snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return RequestServicesModel.fromMap(doc.data());
      }).toList();
    });
  }

  // Stream<List<RequestServicesModel>> getRequestServicesFilter({required String status}) {
  //   log("message get requestServices}");
  //   return _db.collection("requestService")
  //       .where("status", isEqualTo: status.toString())
  //       // .orderBy("timestamp", descending: true)
  //       .snapshots().map((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       return RequestServicesModel.fromMap(doc.data());
  //     }).toList();
  //   });
  // }

  // Stream<List<RequestServicesModel>> getRequestServicesFilter({required String status}) {
  //   return _db
  //       .collection('requestService')
  //       .where('status', isEqualTo: status)
  //       .snapshots()
  //       .asyncMap((snapshot) async {
  //     return await Future.wait(snapshot.docs.map((doc) async {
  //       QuerySnapshot proposalSnapshot = await doc.reference.collection('proposals').get();
  //       int proposalCount = proposalSnapshot.docs.length;
  //       return RequestServicesModel.fromFirestore(doc).copyWith(proposalCount: proposalCount);
  //     }).toList());
  //   });
  // }

  Stream<List<RequestServicesModel>> getRequestServicesFilter({required String status}) {
    return _db
        .collection('requestService')
        .where('status', isEqualTo: status)
        .snapshots()
        .asyncMap((snapshot) async {
      return await Future.wait(snapshot.docs.map((doc) async {
        QuerySnapshot proposalSnapshot = await doc.reference.collection('proposals').get();
        List<SendRequestModel> proposals = proposalSnapshot.docs.map((proposalDoc) {
          return SendRequestModel.fromFirestore(proposalDoc);
        }).toList();
        int proposalCount = proposals.length;

        return RequestServicesModel.fromFirestore(doc).copyWith(
          proposalCount: proposalCount,
          proposals: proposals,
        );
      }).toList());
    });
  }

  Future<void> fetchRequestServicesList() async {
    final snapshot = await _db.collection('requestService').get();
    _requestServices = snapshot.docs
        .map((doc) => RequestServicesModel.fromMap(doc.data()))
        .toList();
    notifyListeners();
  }

  Future<void> fetchProposals({required String id}) async {
    try {
      final querySnapshot = await _db
          .collection('requestService')
          .doc(id)
          .collection('proposals')
          .get();

      _proposals = querySnapshot.docs
          .map((doc) => SendRequestModel.fromFirestore(doc))
          .toList();

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

}