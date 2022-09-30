import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  Future<ThemeMode> themeMode() async {
    final instance = await SharedPreferences.getInstance();
    var theme = instance.getString("theme") ?? "";

    switch (theme) {
      case "dark":
        return ThemeMode.dark;
      case "light":
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> updateThemeMode(ThemeMode theme) async {
    final instance = await SharedPreferences.getInstance();

    switch (theme) {
      case ThemeMode.dark:
        await instance.setString("theme", "dark");
        break;
      case ThemeMode.light:
        await instance.setString("theme", "light");
        break;
      case ThemeMode.system:
        await instance.setString("theme", "system");
        break;
    }
  }
}
