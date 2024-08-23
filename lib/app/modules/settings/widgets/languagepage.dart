import 'package:expensify_app/app/data/translations/translationservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguagePage extends StatelessWidget {
  LanguagePage({super.key});
  final box = GetStorage();
  final TranslationService translationService = TranslationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('English'),
            onTap: () {
              translationService.changeLocale('en');
            },
          ),
          ListTile(
            title: Text('한국어'),
            onTap: () {
              translationService.changeLocale('ko');
            },
          ),
          ListTile(
            title: Text('हिन्दी'),
            onTap: () {
              translationService.changeLocale('hi');
            },
          ),
        ],
      ),
    );
  }
}
