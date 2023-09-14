import 'package:flutter/material.dart';

class DefaultDarkTheme {
  const DefaultDarkTheme(this.context);

  final BuildContext context;
  ThemeData get theme => ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        colorScheme: const ColorScheme.dark().copyWith(
          primary: Colors.white,
          secondary: const Color(0xAA1737EB),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black54,
          shadowColor: Theme.of(context).colorScheme.secondary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        )),
      );
}
