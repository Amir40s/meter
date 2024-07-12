import 'package:get/get.dart';

import '../../constant.dart';
import '../../constant/language/language_utils.dart';
import '../../constant/prefUtils/pref_utils.dart';

class ProfileController extends GetxController {
  final String termsOfService =
      "Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot Europa usa li sam vocabular. Li lingues differe solmen in li grammatica, li pronunciation e li plu commun vocabules. Omnicos directe al desirabilite de un nov lingua franca: On refusa continuar payar custosi traductores. At solmen va esser necessi far uniform grammatica, pronunciation e plu sommun paroles. Ma quande lingues coalesce, li grammatica del resultant lingue es plu simplic e regulari quam ti del coalescent lingues. Li nov lingua franca va esser plu simplic e regulari quam li existent Europan lingues.\n\nIt va esser tam simplic quam Occidental in fact, it va esser Occidental. A un Angleso it va semblar un simplificat Angles, quam un skeptic Cambridge amico dit me que Occidental es.Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot Europa usa li sam vocabular. Li lingues differe solmen in li grammatica, li pronunciation e li plu commun vocabules. Omnicos directe al desirabilite de un nov lingua franca: On refusa continuar payar custosi traductores. At solmen va esser necessi far uniform grammatica, pronunciation e plu sommun paroles."
          .tr;

  final String privacyPolicy =
      "Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot Europa usa li sam vocabular. Li lingues differe solmen in li grammatica, li pronunciation e li plu commun vocabules. Omnicos directe al desirabilite de un nov lingua franca: On refusa continuar payar custosi traductores. At solmen va esser necessi far uniform grammatica, pronunciation e plu sommun paroles. Ma quande lingues coalesce, li grammatica del resultant lingue es plu simplic e regulari quam ti del coalescent lingues. Li nov lingua franca va esser plu simplic e regulari quam li existent Europan lingues.\n\nIt va esser tam simplic quam Occidental in fact, it va esser Occidental. A un Angleso it va semblar un simplificat Angles, quam un skeptic Cambridge amico dit me que Occidental es.Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot Europa usa li sam vocabular. Li lingues differe solmen in li grammatica, li pronunciation e li plu commun vocabules. Omnicos directe al desirabilite de un nov lingua franca: On refusa continuar payar custosi traductores. At solmen va esser necessi far uniform grammatica, pronunciation e plu sommun paroles."
          .tr;

  final String helpDetail = """
  To create a new account, please follow these simple steps:

Open the app and navigate to the login screen.
Below the login form, you'll see an option to "Register" Tap on that.
You will be prompted to enter your Phone Number, Email and Full Name for your account. Please make sure to use a valid Phone Number.
After entering your Phone Number, Email and Full Name, tap on the "Register" button.
A code will be sent to your phone number provided for verification. Please check your inbox and enter the code in the Verification screen to verify your account.
Once your account is verified, the app will automatically log you in.
You can enter some other personal information or skip it.
You can set the required security level for your account or ignore it.
You are now done creating your account.

If you encounter any issues during the sign-up process, feel free to reach out to our support team for assistance.
  """;

  RxString selectedLanguage =
      LanguageUtils.isEnglishLang() ? "English".obs : "ﻋَﺮَﺑِﻲّ".obs;
  RxBool leftIcon = LanguageUtils.isEnglishLang() ? true.obs : false.obs;
  List helpList = ["General", "Account", "Requests", "Payment"];

  RxInt selectedIndex = 0.obs;

  void onChangeSelectedIndex(int newIndex) {
    selectedIndex.value = newIndex;
  }

  void changeSelectedLanguage(String newValue) {
    if (newValue == "English") {
      changeLanguage("en", "US");
      PrefUtil.setBool(PrefUtil.language, true);
      leftIcon.value = true;
    } else {
      leftIcon.value = false;
      PrefUtil.setBool(PrefUtil.language, false);
      changeLanguage("ar", "Ar");
    }
    selectedLanguage.value = newValue;
    print("Current Locale is ${Get.locale}");
  }
}
