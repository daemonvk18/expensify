import 'package:device_preview/device_preview.dart';
import 'package:expensify_app/app/my_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DevicePreview(
      enabled: !kReleaseMode, builder: (context) => const MyApp()));
}
