import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:meter/controller/account/profile_controller.dart';

class LocationUtils {
  static final controller = Get.find<ProfileController>();
  static final user = controller.user.value;
  static double getDistance(String destLat, String destLng) {
    // Parse the string values to double
    double sourceLatitude = double.parse(user.lat);
    double sourceLongitude = double.parse(user.long);
    double destinationLatitude = double.parse(destLat);
    double destinationLongitude = double.parse(destLng);

    double distance = Geolocator.distanceBetween(
      sourceLatitude,
      sourceLongitude,
      destinationLatitude,
      destinationLongitude,
    );

    return distance; // Distance in meters
  }

  static String getDistanceFormatted(String destLat, String destLng) {
    double distance = getDistance(destLat, destLng);

    if (distance >= 1000) {
      // Convert to kilometers if distance is >= 1000 meters
      double kmDistance = distance / 1000;
      return "${kmDistance.toInt()} km";
    } else if (distance >= 1609.34) {
      // Convert to miles if distance is >= 1609.34 meters (1 mile)
      double milesDistance = distance / 1609.34;
      return "${milesDistance.toInt()} miles";
    } else if (distance < 1) {
      // Display in meters if distance is less than 1 meter
      return "${(distance * 1000).toInt()} m";
    } else {
      // Display in meters if distance is less than 1000 meters
      return "${distance.toInt()} m";
    }
  }
}
