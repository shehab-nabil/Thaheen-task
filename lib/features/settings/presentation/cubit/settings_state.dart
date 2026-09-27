import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/theme_mode_pref.dart';

part 'settings_state.freezed.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default('ar') String locale,
    @Default(ThemeModePref.system) ThemeModePref themeMode,
    @Default(1.0) double playbackSpeed,
  }) = _SettingsState;
}
