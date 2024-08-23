import 'package:device_preview/device_preview.dart';
import 'package:expensify_app/app/data/translations/translationservice.dart';
import 'package:expensify_app/app/data/widgets/themedata.dart';
import 'package:expensify_app/app/data/widgets/themeservice.dart';
import 'package:expensify_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    // Get the stored language or default to English
    final TranslationService translationService = TranslationService();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      useInheritedMediaQuery: true,
      translations: translationService,
      locale: translationService.locale,
      fallbackLocale: Locale('en', 'US'),
      builder: DevicePreview.appBuilder,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeService().theme,
    );
  }
}
