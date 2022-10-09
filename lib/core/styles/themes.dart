import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF282828),
          secondary: const Color(0xFFB39DDB).withOpacity(0.5),
          background: const Color(0xFF121212),
          surface: const Color(0xFF181818),
          outline: const Color(0xFF404040),
          onBackground: const Color(0xFFB3B3B3),
          onSurface: const Color(0xFFB3B3B3),
          error: const Color(0xFF601410),
          brightness: Brightness.dark,
        ),
        dividerTheme: const DividerThemeData(
          color: Color(0xFF404040),
          thickness: 2.0,
        ));
  }
}
