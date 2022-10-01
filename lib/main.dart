import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:journal/src/app.dart';
import 'package:journal/src/services/data_provider.dart';
import 'package:journal/src/services/meta_data_provider.dart';
import 'package:journal/src/settings/settings_controller.dart';
import 'package:journal/src/settings/settings_service.dart';

Future<void> main() async {
  var w = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: w);
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  await JournalProvider().getInstance();
  await MetaDataProvider().getInstance(); // here splash gets removed

  runApp(
    MyApp(settingsController: settingsController),
  );
}
