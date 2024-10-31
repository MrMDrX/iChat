import 'package:flutter/material.dart';
import 'package:ichat/themes/theme.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeData _themeData;

  ThemeProvider() : _themeData = _getInitialTheme();

  static ThemeData _getInitialTheme() {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return (brightness == Brightness.dark) ? darkTheme : lightTheme;
  }

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkTheme;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData = _themeData == darkTheme ? lightTheme : darkTheme;
    notifyListeners();
  }
}
