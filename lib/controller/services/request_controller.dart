import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestController extends GetxController {
  List<String> titles = [
    "Applicant's name",
    "Applicant type",
    "Agency number",
    "Phone number",
    "ID number",
    "Instrumental number",
    "Piece number",
    "Chart number",
    "Region",
    "City",
    "Neighborhood",
    "Street",
    "Electronic signature",
  ];

// Values (replace these with the relevant values)
  List<String> values = [
    "John Doe",
    "Individual",
    "12345",
    "555-1234",
    "987654321",
    "67890",
    "A123",
    "B456",
    "Northern Region",
    "Metropolis",
    "Downtown",
    "Main St",
    "JohnDoeSignature",
    "",
  ];
}
