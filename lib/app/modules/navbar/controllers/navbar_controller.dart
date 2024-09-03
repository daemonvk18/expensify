import 'package:expensify_app/app/modules/home/views/home_view.dart';
import 'package:expensify_app/app/modules/report/controllers/report_controller.dart';
import 'package:expensify_app/app/modules/report/views/report_view.dart';
import 'package:expensify_app/app/modules/settings/views/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavbarController extends GetxController {
  //current index(on which page does the nav bar lie)
  var currentIndex = 1.obs;
  final ReportController reportController = Get.put(ReportController());

  //toggleing the index of the nav bar
  void toggleIndexofNavBar(int index) {
    currentIndex.value = index;
  }

  //pages of the navbat
  List<Widget> nabvarPages = [
    //stas screen
    ReportView(),
    //home screen
    HomeView(),
    //settings screen
    SettingsView()
  ];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    Get.find<ReportController>().loadTodayExpenses();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
