import 'package:cloud_firestore/cloud_firestore.dart';

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
