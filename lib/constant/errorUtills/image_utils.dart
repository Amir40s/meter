import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';

import '../prefUtils/message_utills.dart';
import 'error_utils.dart';

/// Utility class for image-related operations such as compression and uploading.
class ImageUtil {
  /// Compresses an image file.
  ///
  /// Takes an [originalImage] file and compresses it with the specified settings.
  /// Returns the compressed image as an [XFile] if compression is successful, otherwise returns null.

  static Future<XFile?> compressImage(XFile originalImage) async {
    final directory = path.dirname(originalImage.path);
    final fileName = 'compressed_${path.basename(originalImage.path)}.jpg';
    final compressedPath = path.join(directory, fileName);

    final compressedImage = await FlutterImageCompress.compressAndGetFile(
      originalImage.path,
      compressedPath,
      minWidth: 320,
      minHeight: 240,
      quality: 50,
    );

    if (compressedImage != null) {
      final originalSize = await File(originalImage.path).length();
      final compressedSize = await File(compressedImage.path).length();

      print('Original Image Size: ${originalSize ~/ 1024} KB');
      print('Compressed Image Size: ${compressedSize ~/ 1024} KB');

      return XFile(compressedImage.path);
    } else {
      // Compression failed, handle the error
      return null;
    }
  }

  /// Uploads an image file to the Firebase Storage database.
  ///
  /// Takes the [filePath] of the image file and the user's [phoneNumber].
  /// Returns a [String] representing the download URL of the uploaded image.

  static Future<String> uploadToDatabase(String filePath) async {
    try {
      String uniqueId = DateTime.now().millisecondsSinceEpoch.toString();
      File pickedImage = File(filePath);

      if (pickedImage.existsSync()) {
        storage.Reference reference = storage.FirebaseStorage.instance
            .ref()
            .child("Profile Image/$uniqueId");

        // Start the upload task
        storage.UploadTask uploadTask = reference.putFile(pickedImage);

        // Await for upload to complete
        await uploadTask.whenComplete(() => null);

        // After upload is complete, retrieve the download URL
        final downloadUrl = await reference.getDownloadURL();
        return downloadUrl;
      } else {
        throw Exception('File does not exist at the provided path');
      }
    } catch (e) {
      // Handle database errors
      ErrorUtil.handleDatabaseErrors(e);
      rethrow;
    }
  }

  static Future<void> pickAndUpdateImage(RxString pathToUpdate) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // Optional: Compress the image before updating the path
      final XFile? compressImage = await ImageUtil.compressImage(image);
      pathToUpdate.value = compressImage?.path ??
          image
              .path; // Use compressed image path or original if compression is null
    } else {
      // Show an error message if no image was selected
      ShortMessageUtils.showError("Please pick an image");
    }
  }

  static Future<void> pickAndUpdateFile(
      RxString fileName, RxString pathToUpdate) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Allow PDF files
    );

    if (result != null && result.files.isNotEmpty) {
      final pickedFile = result.files.single;
      final double fileSizeInMB = pickedFile.size / (1024 * 1024);

      log("Selected file size: ${fileSizeInMB.toStringAsFixed(2)} MB");
      // Check if file size is greater than 25 MB
      if (pickedFile.size > 25 * 1024 * 1024) {
        ShortMessageUtils.showError("File size should not exceed 25 MB");
        return;
      }

      log("path is ${pickedFile.path}");
      pathToUpdate.value = pickedFile.path!;
      log("Path to update ${pathToUpdate.value}");
      fileName.value = pickedFile.name; // Update the file name
    } else {
      // Show an error message if no file was selected
      ShortMessageUtils.showError("Please pick a file");
    }
  }

  static Future<bool> detectFace(XFile? pickedImage) async {
    if (pickedImage != null) {
      final inputImage = InputImage.fromFilePath(pickedImage.path);
      final faceDetector = FaceDetector(
          options: FaceDetectorOptions(
            enableClassification: true,
            enableContours: true,
            enableLandmarks: true,
            enableTracking: true,
          ));
      List<Face> faces = await faceDetector.processImage(inputImage);
      faceDetector.close();
      if (faces.isNotEmpty) {
        print("Face detected successfully");
        return true;
      } else {
        print("Sorry Face Not detected ");
        return false;
      }
    } else {
      print("No image detected here");
      return false;
    }
  }
}
