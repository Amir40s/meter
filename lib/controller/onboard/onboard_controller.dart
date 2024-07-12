import 'package:get/get.dart';

import '../../constant/res/app_images/app_images.dart';

class OnBoardController extends GetxController {
  List imagePath = [
    AppImage.surveyReport,
    AppImage.completionCertificate,
    AppImage.accupancyCertificate,
    AppImage.designWork
  ];

  List title = [
    "Survey Reports",
    "Building Completion Certificate",
    "Occupancy Certificate",
    "Design Work"
  ];

  List description = [
    "Accurate and reliable survey reports for all your construction and land assessment needs.",
    "Obtain your occupancy certificate with ease to ensure your building is ready for use.",
    "High-quality design services to bring your construction projects to life.",
    "Ensure your building meets all regulatory standards with our comprehensive completion certificates."
  ];

  List benefitList = [
    [
      "High accuracy and precision",
      "Comprehensive data analysis",
      "Professional and experienced surveyors"
    ],
    [
      "Safety assurance",
      "Regulatory compliance",
      "Professional verification",
      "Safety inspection",
      "Compliance check",
      "Official certification"
    ],
    [
      "Creative and innovative designs",
      "Customized solutions",
      "Professional and experienced designers",
      "Architectural design",
      "Interior design",
      "Landscape design",
    ],
    [
      "Regulatory compliance",
      "Professional inspection and documentation",
      "Quick and efficient process"
    ]
  ];

}
