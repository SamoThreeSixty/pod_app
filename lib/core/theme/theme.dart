import "package:flutter/material.dart";
import "package:pod_app/core/theme/app_palette.dart";

class AppTheme {
  static _border([Color color = AppPalette.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      );

  static final defaultThemeMode = ThemeData(
    appBarTheme: const AppBarTheme(
        backgroundColor: AppPalette.backgroundColor,
        foregroundColor: AppPalette.foregroundColor),
    scaffoldBackgroundColor: AppPalette.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(),
      focusedBorder: _border(AppPalette.gradient2),
      errorBorder: _border(),
    ),
    colorScheme: const ColorScheme.light(
      surface: AppPalette.backgroundColor,
    ),
  );

  static final darkThemeMode = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
        backgroundColor: AppDarkPalette.backgroundColor,
        foregroundColor: AppDarkPalette.foregroundColor),
    scaffoldBackgroundColor: AppDarkPalette.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(),
      focusedBorder: _border(AppDarkPalette.gradient2),
      errorBorder: _border(),
    ),
    colorScheme: const ColorScheme.dark(
      surface: AppDarkPalette.backgroundColor,
    ),
  );
}
