import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TranslationService extends Translations {
  static final TranslationService _instance = TranslationService._internal();
  factory TranslationService() => _instance;
  TranslationService._internal();

  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://libretranslate.com/'));
  final _storage = GetStorage();

  Locale get locale {
    var langCode = _storage.read<String>('lang') ?? 'en';
    return Locale(langCode);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en': {},
        'ko': {},
        'hi': {},
      };

  Future<String> translateText(String text, String targetLanguage) async {
    try {
      var response = await _dio.post('/translate', data: {
        'q': text,
        'source': 'en',
        'target': targetLanguage,
        'format': 'text',
      });
      return response.data['translatedText'] ?? text;
    } catch (e) {
      print("Translation error: $e");
      return text;
    }
  }

  void changeLocale(String langCode) {
    var locale = Locale(langCode);
    _storage.write('lang', langCode);
    Get.updateLocale(locale);
  }
}
