import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constant.dart';
import 'dart:developer';

import '../../constant/CollectionUtils/collection_utils.dart';

class UserServices {
  static saveFaceData(String imageUrl) {
    log("UUID is ${getCurrentUid()}");
    CollectionUtils.userCollection.doc(getCurrentUid()).set({
      "isFaceVerify": true,
      "faceImageUrl": imageUrl,
    }, SetOptions(merge: true));
  }

  static saveFingerData() {
    CollectionUtils.userCollection.doc(getCurrentUid()).set({
      "isFingerVerify": true,
    }, SetOptions(merge: true));
  }

  static Future<String> getRoleByUid() async {
    try {
      DocumentSnapshot userDoc =
          await CollectionUtils.userCollection.doc(getCurrentUid()).get();
      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>?;
        log("Role is ${data?["role"]}");
        return data?['role'] as String;
      } else {
        return "Customer";
      }
    } catch (e) {
      return "Customer";
    }
  }

  static Future<void> deleteAccount() async {
    try {
      await CollectionUtils.userCollection.doc(getCurrentUid()).delete();

      log("User account deleted successfully");
    } catch (e) {
      log("Failed to delete user account: $e");
      // Handle error as needed
    }
  }
}
