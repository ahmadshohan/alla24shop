import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alla24/app_widget.dart';
import 'package:alla24/shared/localization/app_localization.dart';
import 'package:easy_localization/easy_localization.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(EasyLocalization(
      supportedLocales: AppLocalization.supportedLocales,
      path: AppLocalization.translationPath,
      fallbackLocale: Locale(AppLocalization.defaultLang),
      child: Alla24App()));
}
