import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter/widgets/check_box_widget.dart';
import 'package:meter/widgets/text_field_country_picker.dart';

import '../../constant/res/app_color/app_color.dart';
import '../../controller/login/login_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/text_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Column(
      children: [
        SizedBox(
          height: Get.height * 0.02,
        ),
        Obx(
              () => TextFieldCountryPicker(
            hintText: "115203867",
            controller: controller.phoneNumberController,
            flagPath: controller.flagUri.value,
            countryCode: (CountryCode countryCode) {
              controller.onChangeFlag(countryCode.flagUri ?? "",
                  countryCode.dialCode ?? "", countryCode.code ?? "");
            },
            title: "Phone Number".tr,
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Transform.translate(
          offset: const Offset(-10, 0),
          child: Obx(() => CheckBoxWidget(
           checkValue:  controller.isChecked.value,
          title:   const TextWidget(
                title: "Remember me",
                textColor: AppColor.semiTransparentDarkGrey,
                fontSize: 14),
               onChanged:  (newValue) => controller.toggleCheckbox(newValue),
          )),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Obx(() => controller.sendCodeLoading.value
            ? const CustomLoading()
            : MyCustomButton(
            title: "Send Code".tr,
            onTap: () {
              controller.onSendCode(context);
              // Get.put(SellerAuthController()).authenticatePhoneNumber(context);
              // Get.to(const VerificationScreen());
            }))
      ],
    );
  }
}
