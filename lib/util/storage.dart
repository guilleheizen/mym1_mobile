import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static final StorageUtil instance = StorageUtil._internal();
  SharedPreferences? _prefs;

  StorageUtil._internal();

  Future<SharedPreferences> _init() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<bool> getAmountVisibility() async {
    final prefs = await _init();
    return prefs.getBool("amountVisibility") ?? true;
  }

  Future<void> setAmountVisibility(bool amountVisibility) async {
    final prefs = await _init();
    prefs.setBool('amountVisibility', amountVisibility);
  }

  _systemBarBlack() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarIconBrightness: Brightness.dark));
  }

  _systemBarWhite() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarIconBrightness: Brightness.light));
  }

  Future<ThemeMode> getThemeMode(Brightness brightness) async {
    final prefs = await _init();
    String theme = prefs.getString("themeSettings") ?? 'system';

    if (theme == 'system') {
      if (brightness == Brightness.dark) {
        theme = 'dark';
      } else {
        theme = 'light';
      }
    }

    if (theme == 'light') {
      _systemBarBlack();
      return ThemeMode.light;
    }

    _systemBarWhite();
    return ThemeMode.dark;
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    final prefs = await _init();

    if (themeMode == ThemeMode.light) {
      _systemBarBlack();
      prefs.setString('themeSettings', 'light');
    } else {
      _systemBarWhite();
      prefs.setString('themeSettings', 'dark');
    }
  }

  Future<String?> getToken() async {
    final prefs = await _init();
    return prefs.getString('token');
  }

  Future<void> setToken(String token) async {
    final prefs = await _init();
    prefs.setString('token', token);
  }

  Future<void> removeToken() async {
    final prefs = await _init();
    prefs.remove('token');
  }
}
