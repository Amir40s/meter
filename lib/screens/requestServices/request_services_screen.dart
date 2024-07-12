import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/screens/requestServices/request_service/request_service1.dart';
import '../../bottomSheet/purposePricing/purpose_pricing_bottom_sheet.dart';
import '../../bottomSheet/surveyReport/survey_report_bottom_sheet.dart';
import '../../constant/prefUtils/message_utills.dart';
import '../../constant/res/app_color/app_color.dart';
import '../../constant/validationUtils/validation_utils.dart';
import '../../controller/services/engineering_request_service_controller.dart';
import '../../controller/services/request_service_consolation_controller.dart';
import '../../controller/services/request_service_controler.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_linear_progress.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/radio/group_raadio_widget.dart';
import '../../widgets/text_widget.dart';
import 'consolation/consolation_main.dart';
import 'consolation/consolation_request_service.dart';
import 'engineeringjob/engineering_job.dart';
import 'engineeringjob/engineering_request_service.dart';

class RequestServicesScreen extends StatelessWidget {
  const RequestServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RequestServiceController controller =
        Get.put(RequestServiceController());

    final consolationController =
        Get.put(RequestServiceConsolationController());
    final engineeringJobController =
        Get.put(EngineeringRequestServiceController());

    final _formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          height: Get.height * 0.08,
          margin:
              const EdgeInsets.only(bottom: 10, top: 7, left: 14, right: 14),
          child: MyCustomButton(
              title: "Continue".tr,
              onTap: () {
                print("Value ${controller.selectedTypeOfApplicant}");
                if (controller.selectedRadio.value == "consolation") {
                  if (consolationController.consolationFormKey.currentState!
                          .validate() &&
                      consolationController.validatePhoneNumber()) {
                    Get.to(ConsolationRequestService());
                  } else if (!controller.validatePhoneNumber()) {
                    ShortMessageUtils.showError(
                        "Please enter valid phone number");
                    // Get.to(ConsolationRequestService());
                  } else {
                    ShortMessageUtils.showError(
                        "Please enter valid phone number");
                  }
                } else if (controller.selectedRadio.value ==
                    "request_service") {
                  if (_formKey.currentState!.validate()) {
                    Get.to(const RequestFirstService());
                  } else {
                    ShortMessageUtils.showError("Please fill all fields");
                  }
                } else {
                  if (engineeringJobController
                      .engineeringJobFormKey.currentState!
                      .validate()) {
                    Get.to(EngineeringRequestService());
                  } else {
                    ShortMessageUtils.showError("Please fill all fields");
                  }
                }
              }),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomHeader(
                  title: "Request a service",
                  showProgress: false,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 14.0, right: 14),
                  child: CustomLinearProgress(
                    value: 0.3,
                    backgroundColor: AppColor.lightGreyShade,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: TextWidget(
                    title: "Type Of Activity",
                    textColor: AppColor.semiDarkGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    children: [
                      Obx(
                        () => Expanded(
                          child: columnWithRadio(
                              "Consolation",
                              controller.selectedRadio.value,
                              "consolation",
                              (newValue) =>
                                  controller.setSelectedRadio(newValue!),
                              controller.selectedRadio.value == "consolation",
                              () {
                            controller.setSelectedRadio("consolation");
                          }),
                        ),
                      ),
                      SizedBox(width: Get.width * 0.02),
                      Obx(
                        () => Expanded(
                          child: columnWithRadio(
                              "Request Service",
                              controller.selectedRadio.value,
                              "request_service",
                              (newValue) {
                                controller.setSelectedRadio(newValue!);
                              },
                              controller.selectedRadio.value ==
                                  "request_service",
                              () {
                                controller.setSelectedRadio("request_service");
                              }),
                        ),
                      ),
                      SizedBox(width: Get.width * 0.02),
                      Obx(
                        () => Expanded(
                          child: columnWithRadio(
                              "Engineering Job",
                              controller.selectedRadio.value,
                              "engineering_job",
                              (newValue) {
                                controller.setSelectedRadio(newValue!);
                              },
                              controller.selectedRadio.value ==
                                  "engineering_job",
                              () {
                                controller.setSelectedRadio("engineering_job");
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  if (controller.selectedRadio.value == "request_service") {
                    return Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
                          CustomTextField(
                            validator: ValidationUtils.validateRequired(
                                "Choose purpose of pricing"),
                            hintText: "Choose purpose of pricing",
                            title: "Purpose Of Pricing",
                            dropDownColor: AppColor.primaryColor,
                            controller: controller.purposeOfPricingController,
                            readOnly: true,
                            onChangeDropDown: (newValue) {},
                            dropDownItems: [],
                            onTap: () {
                              Get.bottomSheet(PurposePricingBottomSheet(),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  isScrollControlled: true);
                            },
                          ),
                          CustomTextField(
                            validator: ValidationUtils.validateRequired(
                                "Purpose Of Survey Report"),
                            hintText: "Choose purpose of cadastral report",
                            title: "Purpose Of Survey Report",
                            dropDownColor: AppColor.primaryColor,
                            controller:
                                controller.purposeOfSurveyReportController,
                            readOnly: true,
                            onTap: () {
                              Get.bottomSheet(const SurveyReportBottomSheet(),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  isScrollControlled: true);
                            },
                            onChangeDropDown: (newValue) {},
                            dropDownItems: [
                              // "Survey Report1".tr,
                              // "Survey Report2".tr
                            ],
                          ),
                          CustomTextField(
                              validator: ValidationUtils.validateRequired(
                                  "Survey Report Number"),
                              hintText: "Enter Report Number",
                              title: "Survey Report Number",
                              textInputType: TextInputType.number,
                              controller:
                                  controller.surveyReportNumberController),
                          CustomTextField(
                              validator: ValidationUtils.validateRequired(
                                  "Instrument Number"),
                              hintText: "Enter Instrument Number",
                              title: "Instrument Number",
                              textInputType: TextInputType.number,
                              controller:
                                  controller.instrumentNumberController),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                        ],
                      ),
                    );
                  } else if (controller.selectedRadio.value == "consolation") {
                    return const ConsolationMain();
                  } else if (controller.selectedRadio.value ==
                      "engineering_job") {
                    return const EngineeringJob();
                  } else {
                    return Container(); // Placeholder or default container
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
