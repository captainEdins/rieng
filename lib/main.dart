import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rieng/pages/holder/mainHolder.dart';
import 'package:rieng/pages/splashScreen/splashScreen.dart';
import 'package:rieng/service/themeService.dart';
import 'package:rieng/util/theme.dart';
import 'package:timezone/data/latest.dart' as tz;


import 'service/notificationService.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  NotificationService().initNotification();
  tz.initializeTimeZones();
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // home: const Splashscreen(),
      home: const MainHolder(),
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
    );
  }
}
