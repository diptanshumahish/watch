import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final AutoDisposeChangeNotifierProvider<ThemeNotifier> themeProvider = ChangeNotifierProvider.autoDispose(
  name: 'themeProvider',
  (AutoDisposeChangeNotifierProviderRef<ThemeNotifier> ref) => ThemeNotifier(),
);

class ThemeNotifier extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
       Brightness brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
