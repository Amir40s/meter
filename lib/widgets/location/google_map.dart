import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meter/widgets/custom_button.dart';
import 'package:meter/widgets/custom_header.dart';
import 'package:meter/widgets/custom_textfield.dart';
import '../../controller/location/location_controller.dart';

class GoogleMapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var googleP = Get.put(GoogleProvider());

    googleP.getUserCurrentLocation();
    googleP.location();

    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Obx(() {
            return Column(
              children: [
                const CustomHeader(title: "Google Map"),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Stack(
                  children: [
                    SizedBox(
                      width: Get.width,
                      height: Get.height * 0.40,
                      child: GoogleMap(
                        initialCameraPosition: googleP.kGooglePlex.value,
                        markers: <Marker>{
                          Marker(
                            markerId: const MarkerId("1"),
                            position: LatLng(
                                googleP.kGooglePlex.value.target.latitude,
                                googleP.kGooglePlex.value.target.longitude),
                          ),
                        },
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        onMapCreated: (controller) {
                          googleP.gController.complete(controller);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 5),
                          CustomTextField(
                              hintText: "Search Places with Name",
                              title: "",
                              showSpace: false,
                              onTap: () {
                                googleP.suggestions.value = true;
                              },
                              onChanged: (newValue) {
                                googleP.onChanged(newValue);
                              },
                              controller: googleP.searchController),
                          if (googleP.suggestions.value)
                            Obx(() => SizedBox(
                                  height: Get.width * 0.40,
                                  width: Get.height * 0.20,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: googleP.placesList.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          googleP.suggestions.value = false;
                                          FocusScope.of(context).unfocus();
                                          List<Location> locations =
                                              await locationFromAddress(
                                                  googleP.placesList[index]
                                                      ["description"]);
                                          googleP.moveLocation(
                                              locations.last.latitude,
                                              locations.last.longitude,
                                              index);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          width: 100,
                                          decoration: const BoxDecoration(
                                              color: Colors.white),
                                          child: Text(googleP.placesList[index]
                                              ["description"]),
                                        ),
                                      );
                                    },
                                  ),
                                )),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: CustomButton(
                      title: "Save",
                      onTap: () => googleP.saveLocation(context)),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
