import 'package:flutter/material.dart';
import 'package:journal/src/screens/main_page.dart';
import 'package:journal/src/settings/settings_controller.dart';

import 'screens/settings_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.settingsController});
  // This widget is the root of your application.

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'Journal',
          debugShowCheckedModeBanner: false,
          restorationScopeId: "app",
          theme: ThemeData(),
          //primarySwatch: Colors.blue,
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case Settings.routeName:
                    return Settings(settingsController: settingsController);
                  default:
                    return const MainPage();
                }
              },
            );
          },
        );
      },
    );
  }
}
