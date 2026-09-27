import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/storage/cache_keys.dart';
import '../models/theme_mode_pref.dart';

abstract class SettingsCacheDataSource {
  String getLocale();
  Future<void> setLocale(String locale);

  ThemeModePref getThemeMode();
  Future<void> setThemeMode(ThemeModePref mode);

  double getPlaybackSpeed();
  Future<void> setPlaybackSpeed(double speed);
}

class SettingsCacheDataSourceImpl implements SettingsCacheDataSource {
  const SettingsCacheDataSourceImpl(this._preferences);

  final SharedPreferences _preferences;

  static const String _defaultLocale = 'ar';
  static const double _defaultPlaybackSpeed = 1.0;

  @override
  String getLocale() => _preferences.getString(CacheKeys.locale) ?? _defaultLocale;

  @override
  Future<void> setLocale(String locale) {
    return _preferences.setString(CacheKeys.locale, locale);
  }

  @override
  ThemeModePref getThemeMode() {
    final raw = _preferences.getString(CacheKeys.themeMode);
    return ThemeModePref.values.firstWhere(
      (mode) => mode.name == raw,
      orElse: () => ThemeModePref.system,
    );
  }

  @override
  Future<void> setThemeMode(ThemeModePref mode) {
    return _preferences.setString(CacheKeys.themeMode, mode.name);
  }

  @override
  double getPlaybackSpeed() {
    return _preferences.getDouble(CacheKeys.playbackSpeed) ?? _defaultPlaybackSpeed;
  }

  @override
  Future<void> setPlaybackSpeed(double speed) {
    return _preferences.setDouble(CacheKeys.playbackSpeed, speed);
  }
}
