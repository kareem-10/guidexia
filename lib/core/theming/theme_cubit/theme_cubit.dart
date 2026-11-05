import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/core/helpers/cache_helper.dart';
import 'package:tourist_app/core/theming/theme_cubit/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  static const String _themeModeKey = 'theme_mode';

  final CacheHelper _cacheHelper;

  ThemeCubit(this._cacheHelper) : super(const ThemeState());

  static ThemeMode readSavedThemeMode(CacheHelper cacheHelper) {
    final value = cacheHelper.getData(key: _themeModeKey);
    if (value is String) {
      return ThemeMode.values.firstWhere(
        (mode) => mode.name == value,
        orElse: () => ThemeMode.light,
      );
    }
    return ThemeMode.light;
  }

  void loadSavedTheme() {
    emit(state.copyWith(themeMode: readSavedThemeMode(_cacheHelper)));
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    emit(state.copyWith(themeMode: mode));
    await _cacheHelper.saveData(key: _themeModeKey, value: mode.name);
  }

  Future<void> toggleDarkMode(bool isDark) async {
    await setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}
