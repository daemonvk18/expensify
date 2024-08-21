import 'package:device_preview/device_preview.dart';
import 'package:expensify_app/app/modules/home/controllers/home_controller.dart';
import 'package:expensify_app/app/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  //injecting the homecontroller
  Get.put(HomeController());
  runApp(DevicePreview(
      enabled: !kReleaseMode, builder: (context) => const MyApp()));
}
