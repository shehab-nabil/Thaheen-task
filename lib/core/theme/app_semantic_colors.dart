import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Design-token colors that don't map onto [ColorScheme] slots.
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.border,
    required this.primarySoft,
    required this.inProgressText,
    required this.inProgressBackground,
    required this.lockedIcon,
    required this.lockedBackground,
    required this.track,
  });

  final Color border;
  final Color primarySoft;
  final Color inProgressText;
  final Color inProgressBackground;
  final Color lockedIcon;
  final Color lockedBackground;
  final Color track;

  static const AppSemanticColors light = AppSemanticColors(
    border: AppColors.borderLight,
    primarySoft: AppColors.primarySoftLight,
    inProgressText: AppColors.inProgressTextLight,
    inProgressBackground: AppColors.inProgressBackgroundLight,
    lockedIcon: AppColors.lockedIconLight,
    lockedBackground: AppColors.lockedBackgroundLight,
    track: AppColors.trackLight,
  );

  static const AppSemanticColors dark = AppSemanticColors(
    border: AppColors.borderDark,
    primarySoft: AppColors.primarySoftDark,
    inProgressText: AppColors.inProgressTextDark,
    inProgressBackground: AppColors.inProgressBackgroundDark,
    lockedIcon: AppColors.lockedIconDark,
    lockedBackground: AppColors.lockedBackgroundDark,
    track: AppColors.trackDark,
  );

  @override
  AppSemanticColors copyWith({
    Color? border,
    Color? primarySoft,
    Color? inProgressText,
    Color? inProgressBackground,
    Color? lockedIcon,
    Color? lockedBackground,
    Color? track,
  }) {
    return AppSemanticColors(
      border: border ?? this.border,
      primarySoft: primarySoft ?? this.primarySoft,
      inProgressText: inProgressText ?? this.inProgressText,
      inProgressBackground: inProgressBackground ?? this.inProgressBackground,
      lockedIcon: lockedIcon ?? this.lockedIcon,
      lockedBackground: lockedBackground ?? this.lockedBackground,
      track: track ?? this.track,
    );
  }

  @override
  AppSemanticColors lerp(ThemeExtension<AppSemanticColors>? other, double t) {
    if (other is! AppSemanticColors) return this;
    return AppSemanticColors(
      border: Color.lerp(border, other.border, t)!,
      primarySoft: Color.lerp(primarySoft, other.primarySoft, t)!,
      inProgressText: Color.lerp(inProgressText, other.inProgressText, t)!,
      inProgressBackground: Color.lerp(
        inProgressBackground,
        other.inProgressBackground,
        t,
      )!,
      lockedIcon: Color.lerp(lockedIcon, other.lockedIcon, t)!,
      lockedBackground: Color.lerp(
        lockedBackground,
        other.lockedBackground,
        t,
      )!,
      track: Color.lerp(track, other.track, t)!,
    );
  }
}

extension AppSemanticColorsX on BuildContext {
  AppSemanticColors get semanticColors =>
      Theme.of(this).extension<AppSemanticColors>()!;
}
