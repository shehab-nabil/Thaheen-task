import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';

enum ThemeModePref { light, dark, system }

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default('ar') String locale,
    @Default(ThemeModePref.system) ThemeModePref themeMode,
    @Default(1.0) double playbackSpeed,
  }) = _SettingsState;
}
