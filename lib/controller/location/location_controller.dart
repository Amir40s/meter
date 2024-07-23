import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meter/constant.dart';
import 'package:meter/controller/services/engineering_request_service_controller.dart';
import 'package:meter/controller/services/request_service_consolation_controller.dart';
import 'package:meter/controller/services/request_service_controler.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GoogleProvider extends GetxController {
  RxBool suggestions = false.obs;

  TextEditingController searchController = TextEditingController();

  RxList<dynamic> placesList = [].obs;

  var uuid = const Uuid();
  RxString sessionToken = "".obs;

  Completer<GoogleMapController> gController = Completer();

  Rx<CameraPosition> kGooglePlex = const CameraPosition(
    target: LatLng(31.418715, 73.079109),
    zoom: 14,
  ).obs;

  RxString garageLatitude = "".obs;
  RxString garageLongitude = "".obs;

  @override
  void onInit() {
    // Initialize session token when the controller is initialized
    sessionToken.value = uuid.v4();
    log("UUId is ${sessionToken}");
    super.onInit();
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      debugPrint("$error");
    });
    return await Geolocator.getCurrentPosition();
  }

  void saveLocation(BuildContext context) {
    Get.back();
  }

  void location() {
    getUserCurrentLocation().then((value) async {
      kGooglePlex.value = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );

      GoogleMapController controller = await gController.future;
      await controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(value.latitude, value.longitude), zoom: 14)));
      garageLatitude.value = value.latitude.toString();
      garageLongitude.value = value.longitude.toString();
      List<Placemark> place =
          await placemarkFromCoordinates(value.latitude, value.longitude);
      searchController.text =
          "${place.reversed.last.street}, ${place.reversed.last.subLocality},"
          " ${place.reversed.last.locality}, ${place.reversed.last.postalCode} ${place.reversed.last.country}";
      final requestController = Get.find<RequestServiceController>();
      final engineeringJobController =
          Get.find<EngineeringRequestServiceController>();
      final consolationController =
          Get.find<RequestServiceConsolationController>();
      requestController.locationController.text = searchController.text;
      consolationController.locationController.text = searchController.text;
      engineeringJobController.cityController.text =
          place.reversed.last.locality.toString();
      engineeringJobController.latitude.text = value.latitude.toString();
      engineeringJobController.longitude.text = value.longitude.toString();
      requestController.latitude.text = value.latitude.toString();
      requestController.longitude.text = value.longitude.toString();
      consolationController.latitude.text = value.latitude.toString();
      consolationController.longitude.text = value.longitude.toString();
    });
  }

  void moveLocation(double latitude, double longitude, int index) async {
    final requestController = Get.find<RequestServiceController>();
    final engineeringJobController =
        Get.find<EngineeringRequestServiceController>();
    final consolationController =
        Get.find<RequestServiceConsolationController>();
    requestController.locationController.text =
        placesList[index]["description"];
    consolationController.locationController.text =
        placesList[index]["description"];
    engineeringJobController.cityController.text =
        placesList[index]["description"];
    engineeringJobController.latitude.text = latitude.toString();
    engineeringJobController.longitude.text = longitude.toString();
    requestController.latitude.text = latitude.toString();
    requestController.longitude.text = longitude.toString();
    consolationController.latitude.text = latitude.toString();
    consolationController.longitude.text = longitude.toString();

    searchController.text = placesList[index]["description"];
    kGooglePlex.value =
        CameraPosition(target: LatLng(latitude, longitude), zoom: 14);
    GoogleMapController controller = await gController.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 14)));
    update();
  }

  void onChanged(String searchResult) {
    getSuggestion(searchResult);
  }

  void getSuggestion(String input) async {
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$mapAPIKEY&sessiontoken=$sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    log(data);
    if (response.statusCode == 200) {
      placesList.value = jsonDecode(response.body.toString())["predictions"];
      update();
    } else {
      throw Exception("Failed to Load ");
    }
  }
}
