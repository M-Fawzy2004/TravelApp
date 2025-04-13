// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _ar = {
  "OnboardingView": {
    "welcome": "أهلا بك فى تطبيق رحلة",
    "details": "تطبيق يساعدك علي مشاركه رحلاتك مع الاخرين فى منطقتك. سواء كنت سائقا او راكبا.",
    "details2": "اكتشف الرحلات المتاحه وشارك فى التنقل بسهوله وفعاليه",
    "start": "ابدء رحلتك الان"
  }
};
static const Map<String,dynamic> _en = {
  "OnboardingView": {
    "welcome": "Welcome to Travel App",
    "details": "Travel App helps you share your trips with others in your area. Whether you're a driver or a passenger.",
    "details2": "Discover available trips and share travel with ease and efficiency",
    "start": "Start your trip now"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": _ar, "en": _en};
}
