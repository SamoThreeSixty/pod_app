import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_them_state.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static const String _themeKey = 'isDarkMode';

  ThemeCubit() : super(ThemeMode.light);

  void toggleTheme() async {
    ThemeMode newMode =
        state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(newMode);

    _saveTheme(newMode);
  }

  // Load the theme from SharedPreferences
  Future<void> _loadTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool(_themeKey) ?? false;
    emit(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }

  // Save the theme to SharedPreferences
  Future<void> _saveTheme(ThemeMode themeMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_themeKey, themeMode == ThemeMode.dark);
  }
}
