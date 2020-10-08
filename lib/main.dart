import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alla24/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(Alla24App());
}
