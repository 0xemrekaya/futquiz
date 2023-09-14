import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  bool darkTheme = true;
  Future<void> changeTheme() async {
    darkTheme = !darkTheme;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkTheme', darkTheme);
    notifyListeners();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    darkTheme = prefs.getBool('darkTheme') ?? true;
    notifyListeners();
  }
}

final themeNotifierProvider = ChangeNotifierProvider<ThemeNotifier>((ref) {
  return ThemeNotifier();
});
