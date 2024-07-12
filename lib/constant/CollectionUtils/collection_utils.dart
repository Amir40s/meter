import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constant.dart';
import '../../model/devices/devices_model.dart';

class CollectionUtils {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference userCollection = firestore.collection("users");
  static CollectionReference neighborhoodCollection =
      firestore.collection("neighborhood");
  static CollectionReference cityCollection = firestore.collection("city");
  static CollectionReference deviceCategoryCollection =
      firestore.collection("deviceCategory");
  static CollectionReference deviceCollection = firestore.collection("devices");
  static CollectionReference requestServiceCollection =
      firestore.collection("requestService");
}

///This Class Will Contain [Queries] of [Firestore] for Fetching [Data]

class QueryUtil {
  /////////////////        Streams    ///////////////////////////

  static Stream<List<DeviceModel>> fetchDevices() {
    return CollectionUtils.deviceCollection
        .where("userUID", isEqualTo: getCurrentUid())
        .where("deviceApprove", isEqualTo: "false")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                DeviceModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  static Stream<List<DeviceModel>> fetchDevicesForStore() {
    return CollectionUtils.deviceCollection
        .where("deviceApprove", isEqualTo: "false")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                DeviceModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }
}
