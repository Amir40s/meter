import 'package:get/get_navigation/src/root/internacionalization.dart';

import 'language_utils.dart';

class LanguageKey extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US.json': LanguageUtils.getEnglishTranslations(),
        'ar_Ar.json': LanguageUtils.getArabicTranslations(),
      };
}
