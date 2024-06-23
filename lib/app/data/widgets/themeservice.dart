import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService extends GetxService {
  //initialize the get stotrage
  final _box = GetStorage();
  final _key = "isDarkMode";
  // Get the theme mode from storage, if null, return system theme mode
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  // Load theme mode from GetStorage
  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  // Save theme mode to GetStorage
  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  // Toggle between light and dark themes
  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
