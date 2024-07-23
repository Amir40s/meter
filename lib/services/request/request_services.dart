import 'package:meter/model/user/user_model.dart';

import '../../constant/CollectionUtils/collection_utils.dart';
import '../../constant/prefUtils/message_utills.dart';
import '../../model/devices/devices_model.dart';
import '../../model/requestServices/request_services_model.dart';

class RequestServices {
  static Future<void> addDevice(DeviceModel models) async {
    await CollectionUtils.deviceCollection
        .doc(models.id)
        .set(models.toMap())
        .whenComplete(() {});
  }

  static Future<void> addRequestService(RequestServicesModel models) async {
    await CollectionUtils.requestServiceCollection
        .doc(models.id)
        .set(models.toMap())
        .whenComplete(() {});
  }

  static Future<void> deleteDevice(String deviceId) async {
    await CollectionUtils.deviceCollection
        .doc(deviceId)
        .delete()
        .catchError((error) {
      ShortMessageUtils.showError("Error deleting device: $error");
    });
  }

  static Future<void> updateDevice(
      String deviceId, Map<String, dynamic> data) async {
    await CollectionUtils.deviceCollection
        .doc(deviceId)
        .update(data)
        .catchError((error) {
      ShortMessageUtils.showError("Error updating device: $error");
    });
  }
}
