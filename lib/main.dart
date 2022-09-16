import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:journal/src/app.dart';
import 'package:journal/src/services/data_provider.dart';
import 'package:journal/src/services/meta_data_provider.dart';

Future<void> main() async {
  var w = WidgetsFlutterBinding.ensureInitialized();
  await JournalProvider().getInstance();
  await MetaDataProvider().getInstance();
  FlutterNativeSplash.preserve(widgetsBinding: w);
  runApp(const MyApp());
}
