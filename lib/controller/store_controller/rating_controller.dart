import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RatingController extends GetxController {
  final TextEditingController reviewController = TextEditingController();
  RxDouble initialRating = 0.0.obs;
  void updateRating(double newRating) {
    initialRating.value = newRating;
  }
}
