import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mym1_mobile/util/storage.dart';

StorageUtil _storage = StorageUtil.instance;

final settingsProvider = AsyncNotifierProvider<SettingsNotifier, SettingsState>(SettingsNotifier.new);

class SettingsNotifier extends AsyncNotifier<SettingsState> {
  @override
  Future<SettingsState> build() async {
    final brightness = PlatformDispatcher.instance.platformBrightness;

    final themeMode = await _storage.getThemeMode(brightness);

    return SettingsState(
      themeMode: themeMode,
    );
  }

  void toggleThemeMode(Brightness mediaQueryThemeMode) {
    state = AsyncValue.data(state.value!.toggleThemeMode(mediaQueryThemeMode));
  }
}

class SettingsState {
  SettingsState({
    required this.themeMode,
  });

  ThemeMode themeMode = ThemeMode.light;

  SettingsState toggleThemeMode(Brightness actualThemeMode) {
    if (actualThemeMode == Brightness.light) {
      _storage.setThemeMode(ThemeMode.dark);
      themeMode = ThemeMode.dark;
      return this;
    }
    _storage.setThemeMode(ThemeMode.light);
    themeMode = ThemeMode.light;
    return this;
  }
}
