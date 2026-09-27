import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/settings_cache_data_source.dart';
import '../../data/models/theme_mode_pref.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._dataSource)
      : super(
          SettingsState(
            locale: _dataSource.getLocale(),
            themeMode: _dataSource.getThemeMode(),
            playbackSpeed: _dataSource.getPlaybackSpeed(),
          ),
        );

  final SettingsCacheDataSource _dataSource;

  Future<void> toggleLocale() async {
    final next = state.locale == 'ar' ? 'en' : 'ar';
    await _dataSource.setLocale(next);
    if (isClosed) return;
    emit(state.copyWith(locale: next));
  }

  Future<void> toggleThemeMode() async {
    final next = state.themeMode == ThemeModePref.dark
        ? ThemeModePref.light
        : ThemeModePref.dark;
    await _dataSource.setThemeMode(next);
    if (isClosed) return;
    emit(state.copyWith(themeMode: next));
  }

  Future<void> setPlaybackSpeed(double speed) async {
    await _dataSource.setPlaybackSpeed(speed);
    if (isClosed) return;
    emit(state.copyWith(playbackSpeed: speed));
  }
}
