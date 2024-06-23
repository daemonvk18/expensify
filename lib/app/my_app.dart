import 'package:device_preview/device_preview.dart';
import 'package:expensify_app/app/data/widgets/themedata.dart';
import 'package:expensify_app/app/data/widgets/themeservice.dart';
import 'package:expensify_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeService().theme,
    );
  }
}
