import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider(bool isDarkTheme) {
    _darkTheme == isDarkTheme ? true : false;
    changeTheme(isDarkTheme);
  }

  bool? _darkTheme;

  bool? get darkTheme => _darkTheme;
  Future<void> changeTheme(bool value) async {
    _darkTheme = value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkTheme', _darkTheme!);
    notifyListeners();
  }
}
