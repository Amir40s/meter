import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constant/language/language_keys.dart';
import 'constant/prefUtils/pref_utils.dart';
import 'constant/res/app_color/app_color.dart';
import 'constant/routes/routes.dart';
import 'constant/routes/routes_name.dart';
import 'firebase_options.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  PrefUtil.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: Get.locale,
      fallbackLocale: const Locale('en', 'US'),
      translations: LanguageKey(),
      debugShowCheckedModeBanner: false,
      title: 'Meter',
      theme: ThemeData(
        primaryColor: AppColor.primaryColor,
        useMaterial3: false,
      ),
      initialRoute: RoutesName.splashScreen,
      getPages: Routes.routes,

    );
  }
}

