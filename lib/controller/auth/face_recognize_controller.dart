import 'dart:developer';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:meter/constant/errorUtills/image_utils.dart';
import 'package:meter/constant/prefUtils/message_utills.dart';
import 'package:meter/constant/routes/routes_name.dart';
import 'package:meter/services/user/user_services.dart';

class FaceRecognizeController extends GetxController {
  late CameraController _controller;
  late List<CameraDescription> _cameras;
  Rx<CameraDescription?> selectedCamera = Rx<CameraDescription?>(null);
  RxBool isInitialized = false.obs;
  @override
  void onInit() {
    super.onInit();
    _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    _cameras = await availableCameras();
    selectedCamera.value = _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras.first);
    _controller = CameraController(
      selectedCamera.value!,
      ResolutionPreset.high,
      enableAudio: false,
    );
    await _controller.initialize();
    log("Initialized");
    isInitialized.value = true;
  }

  CameraController get cameraController => _controller;
  RxString imagePath = "".obs;
  RxBool isFaceRecognized = false.obs;
  RxString faceImageUrl = "".obs;
  Future<void> captureImage() async {
    if (!_controller.value.isInitialized) {
      print('Error: Camera is not initialized.');
      return;
    }
    try {
      final image = await _controller.takePicture();
      log("Image path is ${image.path}");
      imagePath.value = image.path;
      final bool isFace = await ImageUtil.detectFace(image);
      log("FaceRecognised $isFace ");
      if (isFace) {
        String imageUrl = await ImageUtil.uploadToDatabase(image.path);
        isFaceRecognized.value = true;
        faceImageUrl.value = imageUrl;
        log("Image url is $imageUrl");
      } else {
        isFaceRecognized.value = false;
        imagePath.value = "";
        ShortMessageUtils.showError("Unable to recognize face try again later");
      }
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  RxBool isLoading = false.obs;
  Future<void> onContinueClick() async {
    isLoading.value = true;
    try {
      if (faceImageUrl.value != "") {
        await UserServices.saveFaceData(faceImageUrl.value);
        Get.toNamed(RoutesName.fingerAuth);
      } else {
        ShortMessageUtils.showError("Please capture face first");
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
